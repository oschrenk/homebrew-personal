class ObsidianHeadless < Formula
  desc "Headless client for Obsidian services"
  homepage "https://obsidian.md"
  url "https://registry.npmjs.org/obsidian-headless/-/obsidian-headless-0.0.12.tgz"
  sha256 "6d267fd57753120007e1ab70fcd3f1d0eb0fdae97bf13d5e6b8c69bbeef0fe7d"
  license :cannot_represent

  # Pinned to node@22: better-sqlite3 does not compile against Node 26's V8
  # (PropertyCallbackInfo::This() was removed) and its engines cap at Node 25.
  depends_on "node@22"

  def install
    # Build (and run) against the keg-only node@22 so the native addon's ABI matches.
    ENV.prepend_path "PATH", formula_opt_bin("node@22")

    # Point node-gyp at node@22's bundled headers so it builds the better-sqlite3
    # addon offline instead of downloading them from nodejs.org during configure.
    ENV["npm_config_nodedir"] = formula_opt_prefix("node@22")

    # ignore_scripts: false is needed to compile the better-sqlite3 native addon
    system "npm", "install", *std_npm_args(ignore_scripts: false)

    # btime bundles prebuilt addons for every platform; keep only the arm64
    # macOS slice (our sole target) so foreign-arch ones don't ship and trip
    # `brew audit`.
    btime = libexec/"lib/node_modules/obsidian-headless/btime"
    btime.glob("*").each do |d|
      rm_r(d) if d.basename.to_s != "darwin-arm64"
    end

    # node@22 is keg-only, so wrap each CLI to put it first on PATH at runtime;
    # otherwise the addon (built for node@22) fails to load under another Node.
    libexec.glob("bin/*").each do |f|
      (bin/f.basename).write_env_script f, PATH: "#{formula_opt_bin("node@22")}:$PATH"
    end

    # Wrapper script for the sync service
    (libexec/"obsidian-headless-sync").write <<~BASH
      #!/bin/bash
      CONFIG="$HOME/.config/obsidian-headless/vault"
      if [ ! -f "$CONFIG" ]; then
        echo "Error: $CONFIG not found. Create it with your vault path." >&2
        exit 1
      fi
      VAULT_PATH="$(cat "$CONFIG" | head -1 | tr -d '\\n')"
      if [ -z "$VAULT_PATH" ]; then
        echo "Error: $CONFIG is empty. Add your vault path." >&2
        exit 1
      fi
      exec "#{opt_bin}/ob" sync --path "$VAULT_PATH" --continuous
    BASH
    (libexec/"obsidian-headless-sync").chmod 0755
  end

  service do
    run [opt_libexec/"obsidian-headless-sync"]
    keep_alive successful_exit: false
    log_path var/"log/obsidian-headless-sync.log"
    error_log_path var/"log/obsidian-headless-sync.err"
  end

  def caveats
    <<~EOS
      To use the sync service, create a config file with your vault path:

        mkdir -p ~/.config/obsidian-headless
        echo "/path/to/your/vault" > ~/.config/obsidian-headless/vault

      Then log in and connect your vault:

        cd /path/to/your/vault
        ob login
        ob sync-setup --vault "Your Remote Vault"

      Start the service with:

        brew services start obsidian-headless
    EOS
  end

  test do
    assert_match "Headless client for Obsidian", shell_output("#{bin}/ob --help")
  end
end

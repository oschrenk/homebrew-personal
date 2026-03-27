class ObsidianHeadless < Formula
  desc "Headless client for Obsidian services"
  homepage "https://obsidian.md"
  url "https://registry.npmjs.org/obsidian-headless/-/obsidian-headless-0.0.8.tgz"
  sha256 "f9f83ab6bebdffb9fbdca86527101be2e8cc3af1fae212f022dffa31e02236d5"
  license :cannot_represent

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")

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
    assert_match "obsidian-headless", shell_output("#{bin}/ob --help 2>&1", 1)
  end
end

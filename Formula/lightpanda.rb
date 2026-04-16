class Lightpanda < Formula
  desc "Headless browser built for AI agents and automation"
  homepage "https://github.com/lightpanda-io/browser"
  license "AGPL-3.0-only"
  version "nightly"

  head do
    url "https://github.com/lightpanda-io/browser.git", branch: "main"
    depends_on "zig" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos"
      sha256 "a90d7adf2710f2a0e1db18448194a4104c24420973104dcabf1ca3807066a403"
    end
  end

  def install
    if build.head?
      # Build V8 snapshot first, then build the binary
      system "zig", "build", "-Doptimize=ReleaseFast", "snapshot_creator", "--", "snapshot.bin"
      system "zig", "build", "-Doptimize=ReleaseFast", "-Dsnapshot_path=snapshot.bin"
      bin.install "zig-out/bin/lightpanda"
    else
      bin.install "lightpanda-aarch64-macos" => "lightpanda"
    end
  end

  test do
    assert_match "lightpanda", shell_output("#{bin}/lightpanda --help 2>&1", 1)
  end
end

class Lightpanda < Formula
  desc "Headless browser built for AI agents and automation"
  homepage "https://github.com/lightpanda-io/browser"
  version "0.4.0"
  license "AGPL-3.0-only"

  livecheck do
    url :stable
    strategy :github_latest
  end

  head do
    url "https://github.com/lightpanda-io/browser.git", branch: "main"
    depends_on "zig" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-aarch64-macos"
      sha256 "840547bb7b98743a3e32618a4d120ac4a75e7c3c2d227ecf5ce8d508ddc118b7"
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
    assert_match version.to_s, shell_output("#{bin}/lightpanda version 2>&1")
  end
end

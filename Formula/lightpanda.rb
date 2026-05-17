class Lightpanda < Formula
  desc "Headless browser built for AI agents and automation"
  homepage "https://github.com/lightpanda-io/browser"
  # Tracks the upstream rolling "nightly" release; version is the asset's updated_at date.
  version "2026.05.17"
  license "AGPL-3.0-only"

  livecheck do
    url "https://api.github.com/repos/lightpanda-io/browser/releases/tags/nightly"
    strategy :json do |json|
      asset = json["assets"]&.find { |a| a["name"] == "lightpanda-aarch64-macos" }
      next if asset.nil?

      Date.parse(asset["updated_at"]).strftime("%Y.%m.%d")
    end
  end

  head do
    url "https://github.com/lightpanda-io/browser.git", branch: "main"
    depends_on "zig" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos"
      sha256 "d6d4fcfffb697139e169364d478a26b3ecfc0defc03cc9bc4e7ffa6f7c346e22"
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
    assert_match "nightly", shell_output("#{bin}/lightpanda version 2>&1")
  end
end

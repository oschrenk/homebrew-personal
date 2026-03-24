class Lightpanda < Formula
  desc "Headless browser built for AI agents and automation"
  homepage "https://github.com/lightpanda-io/browser"
  license "AGPL-3.0-only"
  version "nightly"

  on_macos do
    on_arm do
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos"
      sha256 "aed1bdf21c05aaff59dd3c49488f803f4bf227908676674dafe34aeb9602b812"
    end
  end

  def install
    bin.install "lightpanda-aarch64-macos" => "lightpanda"
  end
end

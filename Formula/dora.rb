class Dora < Formula
  desc "Code context CLI for AI agents"
  homepage "https://github.com/butttons/dora"
  license "MIT"
  version "1.6.0"

  on_macos do
    on_arm do
      url "https://github.com/butttons/dora/releases/download/v#{version}/dora-darwin-arm64"
      sha256 "aaa8f34812a65cd033794cd610901e6cd533b5164069e60ffb55bdfb7304b5af"
    end
  end

  def install
    bin.install "dora-darwin-arm64" => "dora"
  end
end

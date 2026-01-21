class Dora < Formula
  desc "Code context CLI for AI agents"
  homepage "https://github.com/butttons/dora"
  license "MIT"
  version "1.4.2"

  on_macos do
    on_arm do
      url "https://github.com/butttons/dora/releases/download/v#{version}/dora-darwin-arm64"
      sha256 "923ea944040364a41631cd829304fa5f04df8acc4c1d6faf33941d9b25d4e6f2"
    end
  end

  def install
    bin.install "dora-darwin-arm64" => "dora"
  end
end

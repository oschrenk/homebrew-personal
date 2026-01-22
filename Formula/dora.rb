class Dora < Formula
  desc "Code context CLI for AI agents"
  homepage "https://github.com/butttons/dora"
  license "MIT"
  version "1.4.3"

  on_macos do
    on_arm do
      url "https://github.com/butttons/dora/releases/download/v#{version}/dora-darwin-arm64"
      sha256 "a6624d44f733c685a9bb38a8dabf6964632839ca2a109e1e73934be24c4ffbc9"
    end
  end

  def install
    bin.install "dora-darwin-arm64" => "dora"
  end
end

class Dora < Formula
  desc "Code context CLI for AI agents"
  homepage "https://github.com/butttons/dora"
  license "MIT"
  version "2.0.0"

  on_macos do
    on_arm do
      url "https://github.com/butttons/dora/releases/download/v#{version}/dora-darwin-arm64"
      sha256 "bcfe53e5f355797a770176520bd0339da25bfd9bb0ac1c7b7d6eb5bade2b8af8"
    end
  end

  def install
    bin.install "dora-darwin-arm64" => "dora"
  end
end

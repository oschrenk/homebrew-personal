class Squawk < Formula
  desc "Linter for Postgres migrations & SQL"
  homepage "https://squawkhq.com/"
  license " GPL-3.0"
  version "2.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sbdchd/squawk/releases/download/v#{version}/squawk-darwin-arm64"
      sha256 "f98ba67e61c7863016d5bec49b47448f741dbfbd82d36e950d446fd7c734cac4"

      def install
        bin.install "squawk-darwin-arm64" => "squawk"
      end
    end
  end
end

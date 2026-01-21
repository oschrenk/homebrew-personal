class Scip < Formula
  desc "SCIP Code Intelligence Protocol"
  homepage "https://github.com/sourcegraph/scip"
  license "Apache-2.0"
  version "0.6.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sourcegraph/scip/releases/download/v#{version}/scip-darwin-arm64.tar.gz"
      sha256 "b14fbbff9d50dc8384cc96cb2dbd2e269eecd98a895e8a0312e6f45b2358a0bc"
      def install
        bin.install "scip"
      end
    end
  end
end

class Msgvault < Formula
  desc "Archive a lifetime of email and chat. Offline search, analytics, and AI query over your full message history"
  homepage "https://github.com/wesm/msgvault"
  license "MIT"
  version "0.7.0"

  on_macos do
    on_arm do
      url "https://github.com/wesm/msgvault/releases/download/v#{version}/msgvault_#{version}_darwin_arm64.tar.gz"
      sha256 "5555fbb1dc1c4e22b259cf93f1771c23bd982c5ede326f5269f3508e79a5f983"
    end
  end

  def install
    bin.install "msgvault"
  end
end

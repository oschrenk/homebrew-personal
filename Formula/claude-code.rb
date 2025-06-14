require "language/node"

class ClaudeCode < Formula
  desc "Command line interface for Claude AI by Anthropic"

  version "1.0.24"
  homepage "https://www.anthropic.com"
  url "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-#{version}.tgz"
  sha256 "5573ebbc0ef233bb69678c006ec32d4cf2f94d1324365aa9ea29cb3e28a123b2"

  license "Anthropic PBC"

  depends_on "node"

  def install
    # Install the package globally within the Homebrew prefix
    system "npm", "install", "-g", "--prefix", prefix, "@anthropic-ai/claude-code@#{version}"
  end

  test do
    system bin/"claude-code", "--help"
  end
end

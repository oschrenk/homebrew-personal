require "language/node"

class ClaudeCode < Formula
  desc "Command line interface for Claude AI by Anthropic"

  version "1.0.35"
  homepage "https://www.anthropic.com"
  url "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-#{version}.tgz"
  sha256 "1a64459da84f190271da2401b26a1fa280de10ebe4ff64d211056f3ba9ab9a87"

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

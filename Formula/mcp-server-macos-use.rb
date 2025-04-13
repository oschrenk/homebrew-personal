class McpServerMacosUse < Formula
  desc "AI agent that controls macOS"
  homepage "https://github.com/mediar-ai/mcp-server-macos-use"
  url "https://github.com/mediar-ai/mcp-server-macos-use.git",
      revision: "24b4c9ff4a4fc3cf6828f05848b32e84b603ae1d"
  license "BSL-1.1"
  version "1"
  head "https://github.com/mediar-ai/mcp-server-macos-use.git", branch: "main"


  livecheck do
    url :stable
    strategy :github_latest
  end

  # The bottles are built on systems with the CLT installed, and do not work
  # out of the box on Xcode-only systems due to an incorrect sysroot.
  pour_bottle? only_if: :clt_installed

  depends_on xcode: ["15.3", :build]

  uses_from_macos "swift" => :build

  def install
    args = if OS.mac?
      ["--disable-sandbox"]
    else
      ["--static-swift-stdlib"]
    end
    system "swift", "build", *args, "-c", "release", "--product", "mcp-server-macos-use"
    bin.install ".build/release/mcp-server-macos-use"
  end

  test do
  end
end

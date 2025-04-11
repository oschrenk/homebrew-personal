class Swiftly < Formula
  desc "Swift toolchain installer and manager"
  homepage "https://github.com/swiftlang/swiftly"
  url "https://github.com/swiftlang/swiftly.git",
      tag:      "0.4.0",
      revision: "7b773c7da285a8926d6f3a319c1364fe25816866"
  license "Apache-2.0"
  revision 1
  version_scheme 1
  head "https://github.com/swiftlang/swiftly.git", branch: "main"

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
    system "swift", "build", *args, "-c", "release", "--product", "swiftly"
    bin.install ".build/release/swiftly"
    doc.install "Documentation/SwiftlyDocs.docc/swiftly-cli-reference.md"
  end

  test do
    assert_match "USAGE: swiftly <subcommand>", shell_output("#{bin}/swiftly --help")
  end
end

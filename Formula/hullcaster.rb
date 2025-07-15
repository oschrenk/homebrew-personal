class Hullcaster < Formula
  desc "Terminal-based podcast manager written in Rust"
  homepage "https://github.com/gilcu3/hullcaster"
  url "https://github.com/gilcu3/hullcaster.git"
  license "GPL-3.0"
  head "https://github.com/gilcu3/hullcaster.git", branch: "main"

  depends_on "rust" => :build
  depends_on "gcc" => :build
  depends_on "pkgconf" => :build
  depends_on "sqlite"

  def install
    system "cargo", "build", "--release"
    bin.install "target/release/hullcaster"
  end

  test do
    assert_match "hullcaster", shell_output("#{bin}/hullcaster --version 2>&1", 0)
  end
end

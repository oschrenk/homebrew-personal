class Hullcaster < Formula
  desc "Terminal-based podcast manager written in Rust"
  homepage "https://github.com/gilcu3/hullcaster"
  version "0.1.2"
  url "https://github.com/gilcu3/hullcaster/archive/refs/tags/v#{version}.tar.gz"
  sha256 "cb3242a11333a227b486ca0c4847f83f2db980e5b2334eca5242172e861e22e0"
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

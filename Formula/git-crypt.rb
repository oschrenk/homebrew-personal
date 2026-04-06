class GitCrypt < Formula
  desc "Transparent file encryption in Git"
  homepage "https://github.com/maxisam/git-crypt"
  url "https://github.com/maxisam/git-crypt/archive/refs/tags/0.8.2.tar.gz"
  sha256 "df9879d96044b49bebaaca1550ee922c46965504fa8ba9b3fc3c7fc5c8a3a1f8"
  license "GPL-3.0-or-later"

  depends_on "openssl@3"

  def install
    system "make", "git-crypt",
           "CXXFLAGS=-std=c++11 -O2 -I#{Formula["openssl@3"].opt_include}",
           "LDFLAGS=-L#{Formula["openssl@3"].opt_lib} -lcrypto"
    bin.install "git-crypt"
  end

  test do
    system bin/"git-crypt", "version"
  end
end

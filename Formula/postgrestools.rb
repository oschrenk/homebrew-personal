class Postgrestools < Formula
  desc "A collection of language tools and a Language Server Protocol (LSP) implementation for Postgres"
  homepage "https://pgtools.dev"
  license "MIT"
  version "0.6.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/supabase-community/postgres-language-server/releases/download/#{version}/postgrestools_aarch64-apple-darwin"
      sha256 "e6cd98ba9031a3ee72fbcc757eb8b8b7448d56c697b0cda9472e4029838b9cbe"

      def install
        bin.install "postgrestools_aarch64-apple-darwin" => "postgrestools"
      end
    end
  end
end

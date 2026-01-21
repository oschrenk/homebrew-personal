require "language/node"

class ScipTypescript < Formula
  desc "SCIP indexer for TypeScript and JavaScript"
  homepage "https://github.com/sourcegraph/scip-typescript"
  license "Apache-2.0"
  version "0.4.0"

  url "https://registry.npmjs.org/@sourcegraph/scip-typescript/-/scip-typescript-#{version}.tgz"
  sha256 "fa4c8398393d2743e1306fdc7eaccfaafe488690bbfed481354abbf5a33559b9"

  depends_on "node"

  def install
    system "npm", "install", "-g", "--prefix", prefix, "@sourcegraph/scip-typescript@#{version}"
  end
end

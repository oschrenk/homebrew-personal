cask "diffity" do
  version "0.1.1"
  sha256 "11eec0999842f94f18a94e9b21c70d14767fdcb3d74563a8c3f90801b9f30371"

  url "https://github.com/nilbuild/diffity/releases/download/v#{version}/Diffity_#{version}_universal.dmg"
  name "Diffity"
  desc "Review code changes GitHub-style with Claude Code in the loop"
  homepage "https://github.com/nilbuild/diffity"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Diffity.app"
end

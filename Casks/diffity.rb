cask "diffity" do
  version "0.2.0"
  sha256 "71ba0610b99b3ca3746006a8452c83493486f7df2266bb3b25eec9cfb46ee50b"

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

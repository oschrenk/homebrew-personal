cask "diffity" do
  version "0.1.0"
  sha256 "73d210530a121db1d6ca11a01b3bb347bbf9fb4e7568d335f827cd0933a51694"

  url "https://github.com/nilbuild/diffity/releases/download/v#{version}/Diffity_#{version}_universal.dmg"
  name "Diffity"
  desc "Review code changes GitHub-style with Claude Code in the loop"
  homepage "https://github.com/nilbuild/diffity"

  depends_on :macos

  app "Diffity.app"
end

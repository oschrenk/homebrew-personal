cask "icon-composer" do
  name "Icon Composer"
  desc "Create Icons"
  homepage "https://developer.apple.com/icon-composer"

  url "https://developer.apple.com/download/files/icon-composer.dmg"
  version :latest
  sha256 :no_check

  app "Icon Composer.app"
end

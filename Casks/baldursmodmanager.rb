cask "baldursmodmanager" do
  name "BaldursModManager"
  desc "Baldur's Gate 3 Mod Manager for macOS"
  homepage "https://github.com/revblaze/BaldursModManager"

  version "0.2.0"
  sha256 "0f57dff182c8d084cb3844f8c628356e6a69d0c9543592736ad76b70cc119845"
  url "https://github.com/revblaze/BaldursModManager/releases/download/v#{version}/BaldursModManager.app.zip"

  app "BaldursModManager.app"
end

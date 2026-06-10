cask "cadova-viewer" do
  version "0.4.0"
  sha256 "a54a5c888f2308636761e814833edf9b9303893567fcf0425aed866b043f6fb2"

  url "https://github.com/tomasf/CadovaViewer/releases/download/#{version}/CadovaViewer#{version}.zip"
  name "Cadova Viewer"
  desc "Viewer for 3MF 3D model files"
  homepage "https://github.com/tomasf/CadovaViewer"

  depends_on :macos

  app "Cadova Viewer.app"
end

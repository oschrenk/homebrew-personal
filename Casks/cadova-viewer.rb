cask "cadova-viewer" do
  name "Cadova Viewer"
  desc "Viewer for 3MF 3D model files"
  homepage "https://github.com/tomasf/CadovaViewer"

  version "0.3.0"
  sha256 "e0c38512982a2a92edb978dac2c4e7425d814d4acd96d5d3bb2cb35f4ce98707"
  url "https://github.com/tomasf/CadovaViewer/releases/download/#{version}/CadovaViewer#{version}.zip"

  app "Cadova Viewer.app"
end

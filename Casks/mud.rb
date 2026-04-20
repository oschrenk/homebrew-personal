cask "mud" do
  name "Mud"
  desc "Markdown viewer with live reload"
  homepage "https://github.com/joseph/mud"

  version "2.0.1"
  sha256 "75d53efefe5a00541442c6b345b1e937ed4a0f8c39292a985980b935c6254e2f"
  url "https://github.com/joseph/mud/releases/download/v#{version}/Mud-v#{version}.dmg"

  app "Mud.app"
end

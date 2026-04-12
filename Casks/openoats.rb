cask "openoats" do
  name "OpenOats"
  desc "Meeting note-taker that transcribes calls and surfaces relevant notes in real time"
  homepage "https://github.com/yazinsai/OpenOats"

  version "1.47.0"
  sha256 "b2e40e8ba54ad18bad2c9832709eb664e2a31779d15082e65e3c9d4fbab93df5"
  url "https://github.com/yazinsai/OpenOats/releases/download/v#{version}/OpenOats.dmg"

  app "OpenOats.app"
end

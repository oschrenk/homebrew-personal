cask "typewhisper" do
  name "TypeWhisper"
  desc "Speech-to-text and AI text processing app"
  homepage "https://github.com/TypeWhisper/typewhisper-mac"

  version "1.1.0"
  sha256 "fdd3563b33162320731e06722f85475dc23ba9fe426fef8b28b04bdd7f0dd679"
  url "https://github.com/TypeWhisper/typewhisper-mac/releases/download/v#{version}/TypeWhisper-v#{version}.dmg"

  app "TypeWhisper.app"
end

cask "readinglist" do
  name "Reading List"
  desc "Browser for Safari's Reading List"
  homepage "https://github.com/marckohlbrugge/readinglist"

  version "1.3.0"
  sha256 "db01b6dbb103b15664cb16188621ac62187d44fd2301676340ad6d52251bede0"
  url "https://github.com/marckohlbrugge/readinglist/releases/download/v#{version}/Reading-List-#{version}.dmg"

  depends_on macos: :sonoma

  app "Reading List.app"
end

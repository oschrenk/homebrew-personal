cask 'font-sf-mono-nerd-font' do

  name 'sf-mono-nerd-font'
  homepage 'https://github.com/oschrenk/sf-mono-nerd-font'

  version "18.0d1e1-3.2.1"
  sha256 "16dad09a8fac480f483410d25b48ab39e13ccba54daf101aeabbc8d28976b917"

  url "https://github.com/oschrenk/sf-mono-nerd-font/archive/refs/tags/v#{version}.zip"

  livecheck do
    url :url
    strategy :github_latest
  end

  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-Bold.otf"
  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-BoldItalic.otf"
  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-Heavy.otf"
  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-HeavyItalic.otf"
  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-Italic.otf"
  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-Light.otf"
  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-LightItalic.otf"
  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-Medium.otf"
  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-MediumItalic.otf"
  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-Regular.otf"
  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-SemiBold.otf"
  font "sf-mono-nerd-font-#{version}/SFMonoNerdFont-SemiBoldItalic.otf"
end

cask "nova" do
  version "1.0"
  sha256 "b5e093b18e9b9967edf208d4e6497569c78463d0ff3dc8cfc78f9fad73bbf1c3"

  url "https://github.com/byLuisMoya/Nova/releases/download/v#{version}/Nova-#{version}.zip"
  name "Nova"
  desc "Monitor de sensores para la barra de menú en Apple Silicon"
  homepage "https://github.com/byLuisMoya/Nova"

  depends_on macos: :ventura
  depends_on arch: :arm64

  app "Nova.app"

  # La app está firmada ad-hoc (sin Apple Developer ID), así que Gatekeeper la
  # bloquearía mientras tenga el atributo de cuarentena que Homebrew le pone.
  # Al quitarlo, macOS deja de intervenir y la app abre con normalidad.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Nova.app"]
  end

  zap trash: [
    "~/Library/LaunchAgents/io.github.byluismoya.Nova.plist",
    "~/Library/Preferences/io.github.byluismoya.Nova.plist",
  ]
end

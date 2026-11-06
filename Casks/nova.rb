cask "nova" do
  version "1.7"
  sha256 "be7dfd57882a03dae1ae68647c691afb20500c4456890ee8925b8563abd5ea9e"

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
    "~/Library/Application Support/Nova",
    "~/Library/LaunchAgents/io.github.byluismoya.Nova.plist",
    "~/Library/Preferences/io.github.byluismoya.Nova.plist",
  ]
end

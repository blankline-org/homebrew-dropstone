cask "dropstone" do
  version "2.0.4"
  sha256 :no_check

  url "https://github.com/blankline-org/dropstone-releases/releases/download/v#{version}/Dropstone-v#{version}-macOS.zip"
  name "Dropstone"
  desc "Self-learning AI IDE that understands your codebase and automates development tasks"
  homepage "https://github.com/blankline-org/dropstone-releases"

  app "Dropstone.app"

  preflight do
    system_command "/bin/rm",
                   args: ["-rf", "#{appdir}/Dropstone.app"],
                   sudo: false
  end

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Dropstone.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.blankline.dropstone.plist",
    "~/Library/Application Support/Dropstone",
  ]
end

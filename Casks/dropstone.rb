cask "dropstone" do
  version "2.0.4"
  sha256 :no_check

  url "https://github.com/blankline-org/dropstone-releases/releases/download/v#{version}/Dropstone-v#{version}-macOS.zip"
  name "Dropstone"
  desc "Self-learning AI IDE that understands your codebase and automates development tasks"
  homepage "https://github.com/blankline-org/dropstone-releases"

  app "Dropstone.app"

  # 'preflight' block removed. 
  # Homebrew automatically handles removing/overwriting previous versions 
  # during upgrades. Manual deletion here causes the "App source not there" error.

  postflight do
    # Removes the quarantine attribute to prevent "App is damaged" errors.
    # We verify the path exists first to be safe.
    target_path = "#{appdir}/Dropstone.app"
    if File.exist?(target_path)
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", target_path],
                     sudo: false
    end
  end

  zap trash: [
    "~/Library/Preferences/com.blankline.dropstone.plist",
    "~/Library/Application Support/Dropstone",
  ]
end

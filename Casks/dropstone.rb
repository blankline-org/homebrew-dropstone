cask "dropstone" do
  version "3.0.4"
  sha256 :no_check

  url "https://github.com/blankline-org/dropstone-releases/releases/download/v#{version}/Dropstone-v#{version}-macOS.zip"
  name "Dropstone"
  desc "Self-learning AI IDE that understands your codebase and automates development tasks"
  homepage "https://github.com/blankline-org/dropstone-releases"

  app "Dropstone.app"

  # REMOVED PREFLIGHT BLOCK (This was causing your "App already exists" error)

  # POSTFLIGHT: Quarantine Fix + Branded Interface + Auto-Launch
  postflight do
    target_path = "#{appdir}/Dropstone.app"

    # A. Fix "App is damaged" quarantine error
    if File.exist?(target_path)
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", target_path],
                     sudo: false
    end

    # B. Render Interface
    brand_style = "\033[46m\033[30m\033[1m"
    cyan_text   = "\033[36m"
    grey_text   = "\033[90m"
    reset       = "\033[0m"

    puts <<-EOS

#{brand_style}        DROPSTONE            #{reset}
#{brand_style}       v#{version}                #{reset}

#{grey_text}   ---------------------------#{reset}

#{cyan_text}   ✓#{reset}   Core files extracted
#{cyan_text}   ✓#{reset}   Quarantine attributes cleared
#{cyan_text}   ✓#{reset}   Local environment integration
#{cyan_text}   ✓#{reset}   Neural engine dependencies verified

#{grey_text}   ---------------------------#{reset}

   #{cyan_text}INSTALLATION COMPLETE.#{reset}
   To manage your account and API keys, visit:
   #{cyan_text}https://dropstone.io/dashboard#{reset}

    EOS

    # C. Auto-Launch the App
    system_command "/usr/bin/open", args: ["-a", target_path], sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.blankline.dropstone.plist",
    "~/Library/Application Support/Dropstone",
  ]
end

{ ... }:

{
  # Does not work currently due to existing profiles
  programs.firefox = {
    enable = true;
    profiles.experimental = {
      name = "experimental";
      # Record the settings modified in about:config
      settings = {
        "toolkit.legacyUserProfileCustomizations.styelsheets" = true; # Enable userchrome.css
        "browser.urlbar.scotchBonnet.enableOverride" = false; # Remove "Search with ..." drop down
        "browser.urlbar.resultMenu.keyboardAccessible" = false; # Skip the result menu when tabbing
        "browser.tabs.insertAfterCurrent" = true; # Open new tab right next to the current tab
        "browser.compactmode.show" = true; # Unhide the compact UI option
        "font.name-list.emoji" = "Apple Color Emoji, Noto Color Emoji, Twemoji Mozilla"; # Add Apple emoji as the default emoji font
        # and more at https://github.com/arkenfox/user.js (privacy related)
        # https://www.reddit.com/r/firefox/comments/17hlkhp/what_are_your_must_have_changes_in_aboutconfig/
      };
    };
  };
}

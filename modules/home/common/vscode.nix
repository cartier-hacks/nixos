{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode; # or pkgs.vscodium for the open-source version

    # Extensions
    profiles.default.extensions =
      with pkgs.vscode-extensions;
      [
        # Misc
        vscodevim.vim
        eamodio.gitlens
        christian-kohler.path-intellisense
        catppuccin.catppuccin-vsc-icons
        foxundermoon.shell-format
        gruntfuggly.todo-tree
        jdinhlife.gruvbox
        redhat.ansible
        redhat.vscode-yaml
        shd101wyy.markdown-preview-enhanced
        ms-vsliveshare.vsliveshare
        pkief.material-icon-theme
        tamasfe.even-better-toml
        # PHP
        bmewburn.vscode-intelephense-client
        # Html/Front End Support
        bradlc.vscode-tailwindcss
        formulahendry.auto-close-tag
        formulahendry.auto-rename-tag
        svelte.svelte-vscode
        vue.volar
        # Go
        golang.go
        mikestead.dotenv
        # Python
        ms-python.debugpy
        ms-python.python
        ms-python.vscode-pylance
        # Rust
        rust-lang.rust-analyzer
        # C++
        ms-vscode.cpptools
        ms-vscode.cmake-tools
        # delgan.qml-format
        # Nix
        mkhl.direnv
        jnoortheen.nix-ide
        # adpyke.vscode-sql-formatter
        # adrianwilczynski.alpine-js-intellisense
        # anthropic.claude-code
        # cierra.livewire-vscode
        # neilbrayfield.php-docblocker
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # Extensions not in nixpkgs
        {
          name = "base16-tinted-themes";
          publisher = "TintedTheming";
          version = "0.27.0";
          sha256 = "7wLBwfaXEoumAfp9kK5Mv1VaGffuGdoYMGZ+ZjN9G8Q=";
        }
        {
          name = "vscode-laravel";
          publisher = "laravel";
          version = "1.0.14";
          sha256 = "DEHr8kAGm6ShdQCThh7MUhv24Ghwg10mGDhZgUIojrY=";
        }
        {
          name = "phpstorm-snippets";
          publisher = "phiter";
          version = "1.1.2";
          sha256 = "EHEzM4YKYR+2r6RVun8tSjGYDsbriBPATNwxczEuqjQ=";
        }
        {
          name = "laravel-blade";
          publisher = "onecentlin";
          version = "1.37.0";
          sha256 = "q5CTRj746404yM9mhOWYAGTzt/8CJ7Fx4QUQSJ+LdLs=";
        }
        {
          name = "vscode-antlers";
          publisher = "stillat-llc";
          version = "2.6.22";
          sha256 = "3JtT5AxtbxciivfG6JaUYNPL74+8ydhDeB7SCE/92ko=";
        }
        # Qt Extension Pack
        {
          name = "qt-qml";
          publisher = "TheQtCompany";
          version = "1.7.0";
          sha256 = "QjfvZIcE4LcJU93YiYN/zykEluHtR7zVOwYiPL0k+cQ=";
        }
        {
          name = "qt-ui";
          publisher = "TheQtCompany";
          version = "1.7.0";
          sha256 = "XDOIyCZIUYPGfcszZMUkR9MHH+zrXZgympKNhcQwITY=";
        }
        {
          name = "qt-core";
          publisher = "TheQtCompany";
          version = "1.7.0";
          sha256 = "2413vMpvxSYBKpaD14sMgI92W8NtCYa/sJ7PZO62WfY=";
        }
      ];

    # User settings
    profiles.default.userSettings = {
      # Disable the fucking copilot chat
      "github.copilot.chat.showChatPanel" = false;
      "github.copilot.enable" = false;
      "window.titleBarStyle" = "custom";
      "window.customTitleBarVisibility" = "auto";
      "workbench.colorTheme" = lib.mkForce "Stylix";
      "git.autofetch" = true;
      "editor.fontSize" = lib.mkForce 18;
      "editor.snippetSuggestions" = "top";
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "qt-qml.qmlls.useQmlImportPathEnvVar" = true;
      "[qml]" = {
        "editor.defaultFormatter" = "Delgan.qml-format";
        "editor.formatOnSave" = true;
      };
      "[yaml]" = {
        "editor.formatOnSave" = false;
      };
      "[astro]" = {
        "editor.formatOnSave" = false;
      };
      "[dockerfile]" = {
        "editor.formatOnSave" = false;
        "editor.formatOnPaste" = false;
        "editor.formatOnType" = false;
        "editor.defaultFormatter" = "ms-azuretools.vscode-containers";
      };
      "tailwindCSS.includeLanguages" = {
        "templ" = "html";
      };
      "emmet.triggerExpansionOnTab" = true;
      "editor.autoIndent" = "full";
      "files.eol" = "\n";
      "emmet.excludeLanguages" = [ ];
      "emmet.includeLanguages" = {
        "blade" = "html";
        "templ" = "html";
        "markdown" = "html";
      };
      "explorer.openEditors.visible" = 0;
      "editor.tabCompletion" = "on";
      "workbench.editor.highlightModifiedTabs" = true;
      "git.enableSmartCommit" = true;
      "extensions.ignoreRecommendations" = true;
      "blade.format.enable" = true;
      "editor.autoClosingBrackets" = "always";
      "material-icon-theme.folders.theme" = "specific";
      "security.workspace.trust.untrustedFiles" = "open";
      "editor.unusualLineTerminators" = "auto";
      "files.associations" = { };
      "intelephense.environment.phpVersion" = "8.1.0";
      "git.useEditorAsCommitInput" = false;
      "editor.inlineSuggest.enabled" = true;
      "[xml]" = {
        "editor.defaultFormatter" = "redhat.vscode-xml";
      };
      "terminal.integrated.fontSize" = lib.mkForce 18;
      "explorer.confirmDragAndDrop" = false;
      "editor.unicodeHighlight.nonBasicASCII" = false;
      "markdown-preview-enhanced.previewTheme" = "github-dark.css";
      "window.commandCenter" = false;
      "workbench.editor.editorActionsLocation" = "hidden";
      "workbench.layoutControl.enabled" = false;
      "editor.minimap.enabled" = false;
      "workbench.activityBar.location" = "hidden";
      "editor.fontFamily" = lib.mkForce "'Fira Code Retina'";
      "editor.fontLigatures" = true;
      "keyboard.dispatch" = "keyCode";
      "workbench.iconTheme" = "catppuccin-frappe";
      "search.useIgnoreFiles" = false;
      "search.exclude" = {
        # Hide everything in /vendor; except the "laravel" and "livewire" folder.
        "**/vendor/{[^l];?[^ai]}*" = true;
        # Hide everything in /public; except "index.php"
        "**/public/{[^i];?[^n]}*" = true;
        "**/node_modules" = true;
        "**/dist" = true;
        "**/_ide_helper.php" = true;
        "**/composer.lock" = true;
        "**/package-lock.json" = true;
        "storage" = true;
        ".phpunit.result.cache" = true;
      };
      "terminal.integrated.stickyScroll.enabled" = false;
      "scm.diffDecorations" = "none";
      "editor.hover.enabled" = false;
      "editor.matchBrackets" = "never";
      "workbench.tips.enabled" = false;
      "editor.colorDecorators" = false;
      "git.decorations.enabled" = false;
      "workbench.startupEditor" = "none";
      "editor.lightbulb.enabled" = "off";
      "editor.selectionHighlight" = false;
      "editor.overviewRulerBorder" = false;
      "editor.renderLineHighlight" = "none";
      "editor.occurrencesHighlight" = "off";
      "problems.decorations.enabled" = false;
      "editor.renderControlCharacters" = false;
      "editor.hideCursorInOverviewRuler" = true;
      "editor.gotoLocation.multipleReferences" = "goto";
      "editor.gotoLocation.multipleDefinitions" = "goto";
      "editor.gotoLocation.multipleDeclarations" = "goto";
      "workbench.editor.enablePreviewFromQuickOpen" = false;
      "editor.gotoLocation.multipleImplementations" = "goto";
      "editor.gotoLocation.multipleTypeDefinitions" = "goto";
      "editor.cursorSurroundingLines" = 200;
      "workbench.editor.pinnedTabsOnSeparateRow" = true;
      "C_Cpp.default.compileCommands" = "\${workspaceFolder}/build/compile_commands.json";
      "C_Cpp.default.configurationProvider" = "ms-vscode.cmake-tools";
      # Rust Analyzer
      "rust-analyzer.inlayHints.chainingHints.enable" = false;
      "rust-analyzer.inlayHints.closingBraceHints.enable" = false;
      "rust-analyzer.inlayHints.parameterHints.enable" = false;
      "rust-analyzer.inlayHints.typeHints.enable" = false;
      "rust-analyzer.inlayHints.closureStyle" = "hide";
      # Antlers (Statamic)
      "antlersLanguageServer.languageVersion" = "runtime";
      "[antlers]" = {
        "editor.defaultFormatter" = "html";
      };
      "window.menuBarVisibility" = "compact";
      "vim.leader" = "<space>";
      "vim.normalModeKeyBindings" = [
        {
          "before" = [
            "g"
            "r"
          ];
          "commands" = [ "editor.action.goToReferences" ];
        }
        {
          "before" = [
            "g"
            "v"
          ];
          "commands" = [ "editor.action.revealDefinitionAside" ];
        }
        {
          "before" = [
            "<leader>"
            "o"
          ];
          "commands" = [ "workbench.action.quickOpen" ];
        }
        {
          "before" = [
            "<leader>"
            "p"
          ];
          "commands" = [ "workbench.action.showCommands" ];
        }
        {
          "before" = [
            "<leader>"
            "i"
          ];
          "commands" = [ "workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup" ];
        }
      ];
      "vim.insertModeKeyBindings" = [
        {
          "before" = [
            "j"
            "j"
          ];
          "after" = [ "<Esc>" ];
        }
      ];
      "vim.visualModeKeyBindings" = [
        {
          "before" = [ "<Enter>" ];
          "after" = [ "<Esc>" ];
        }
      ];
      "workbench.editor.showTabs" = "none";
      "ansible.lightspeed.enabled" = false;
      "ansible.lightspeed.suggestions.enabled" = false;
      "[sql]" = {
        "editor.formatOnSave" = false;
      };
      "svelte.enable-ts-plugin" = true;
      "workbench.sideBar.location" = "left";
      "workbench.panel.defaultLocation" = "left";
    };

    # Keybindings
    profiles.default.keybindings = [
      {
        "key" = "ctrl+k";
        "command" = "git.commitAll";
        "when" = "!inDebugMode && !terminalFocus";
      }
      {
        "key" = "ctrl+shift+k";
        "command" = "git.pushTo";
        "when" = "!inDebugMode && !terminalFocus";
      }
      {
        "key" = "ctrl+shift+n";
        "command" = "workbench.action.quickOpen";
      }
      {
        "key" = "shift+escape";
        "command" = "workbench.action.terminal.toggleTerminal";
      }
      {
        "key" = "ctrl+shift+`";
        "command" = "workbench.action.closeAllEditors";
      }
      {
        "key" = "ctrl+shift+1";
        "command" = "workbench.files.action.collapseExplorerFolders";
      }
      {
        "key" = "ctrl+shift+e";
        "command" = "workbench.view.explorer";
      }
      {
        "key" = "ctrl+shift+e";
        "command" = "workbench.action.toggleSidebarVisibility";
        "when" = "!editorFocus";
      }
      {
        "key" = "ctrl+1";
        "command" = "workbench.action.toggleSidebarVisibility";
      }
      {
        "key" = "ctrl+a";
        "command" = "explorer.newFile";
        "when" = "explorerViewletVisible && filesExplorerFocus && !inputFocus";
      }
      {
        "key" = "ctrl+shift+a";
        "command" = "explorer.newFolder";
        "when" = "explorerViewletVisible && filesExplorerFocus && !inputFocus";
      }
      {
        "key" = "ctrl+d";
        "command" = "deleteFile";
        "when" = "explorerViewletVisible && filesExplorerFocus && !inputFocus";
      }
      {
        "key" = "ctrl+\\";
        "command" = "workbench.action.splitEditorRight";
        "when" = "editorFocus";
      }
      {
        "key" = "ctrl+h";
        "command" = "workbench.action.navigateLeft";
        "when" = "editorFocus";
      }
      {
        "key" = "ctrl+l";
        "command" = "workbench.action.navigateRight";
        "when" = "editorFocus";
      }
      {
        "key" = "ctrl+*";
        "command" = "workbench.action.increaseViewSize";
        "when" = "editorFocus";
      }
      {
        "key" = "ctrl+/";
        "command" = "workbench.action.decreaseViewSize";
        "when" = "editorFocus";
      }
      {
        "key" = "ctrl+shift+w";
        "command" = "workbench.action.joinAllGroups";
        "when" = "editorFocus";
      }
      {
        "key" = "ctrl+shift+alt+p";
        "command" = "editor.emmet.action.wrapWithAbbreviation";
        "when" = "editorTextFocus";
      }
      {
        "key" = "ctrl+shift+alt+i";
        "command" = "editor.emmet.action.balanceIn";
        "when" = "editorTextFocus";
      }
      {
        "key" = "ctrl+shift+alt+o";
        "command" = "editor.emmet.action.balanceOut";
        "when" = "editorTextFocus";
      }
      {
        "key" = "alt+n";
        "command" = "workbench.action.quickOpenSelectNext";
        "when" = "inQuickOpen";
      }
      {
        "key" = "alt+p";
        "command" = "workbench.action.quickOpenSelectPrevious";
        "when" = "inQuickOpen";
      }
      {
        "key" = "alt+0";
        "command" = "workbench.action.closeQuickOpen";
        "when" = "inQuickOpen";
      }
      {
        "key" = "ctrl+shift+\\";
        "command" = "workbench.action.toggleAuxiliaryBar";
      }
    ];
  };
}

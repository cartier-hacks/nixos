{
  config,
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Shell aliases (equivalent to your script functions)
    shellAliases = {
      sudo = "sudo ";
      # Nix
      rb = "git add . && sudo nixos-rebuild switch --flake $HOME/nix#desktop";
      rbl = "git add . && sudo nixos-rebuild switch --flake $HOME/nix#laptop";

      eza = "eza";
      ls = "eza -lh --group-directories-first --icons";
      cat = "bat";
      bat = "bat";

      # Quicker navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      # Git
      gs = "git status";
      ga = "git add -A";
      gc = "git commit -m";
      grm = "git rm $(git ls-files --deleted)";
      gb = "git checkout -b";

      # Docker aliases
      dc = "docker-compose";
      bx = "docker buildx";
      de = "docker exec -it";
      dub = "docker compose up -d --build";
      dup = "docker-compose up";
      dwn = "docker-compose down";
      da = "docker_artisan";

      # Laravel & php
      a = "php artisan";

      # Convenience
      cls = "clear";
      home = "cd ~";
      projects = "cd ~/projects";
      co = "code .";
      clipboard = "wl-copy";

      # Jigsaw
      jig = "vendor/bin/jigsaw";

      # Golang
      gr = "go run .";
      gmt = "go mod tidy";
    };

    # Additional bash configuration
    initContent = ''
        function pape() {
          hyprctl hyprpaper preload $1 
          hyprctl hyprpaper wallpaper ", $1"
        }
        # Open something in the projects folder
        function o() {
          cd "$HOME/projects/$1"
        }

        function proj() {
          eza -ld $HOME/projects/* --color=never |
            awk '{print $7}' |
            wofi --dmenu --prompt "Open project:" | xargs -I{} code {} -n && exit
        }

        function makepasswd() {
          openssl rand -base64 16 | clipboard
          echo "Password copied to clipboard"
        }

        function mountnewshares() {
          sudo systemctl daemon-reload
          sudo mount -a
        }

        function makerole() {
          mkdir -p "roles/$1/tasks"
          mkdir -p "roles/$1/defaults"
          touch "roles/$1/tasks/main.yml"
          touch "roles/$1/defaults/main.yml"
        }

        function pyvenv() {
          python3 -m venv .venv
          source .venv/bin/activate
        }

        function newsshkey() {
          KEY_NAME="id_ed25519_$1"
          KEY_PATH="$HOME/.ssh/$KEY_NAME"
          ssh-keygen -t ed25519 -C "$1" -f "$KEY_PATH" -N ""
          ssh-add "$KEY_PATH"
          echo "Key created and added"
          echo "Key: $KEY_NAME"
          echo "Saved to: $KEY_PATH"
        }

        function listsshkeys() {
          ls "$HOME/.ssh"
        }

        function copypublickey() {
          KEY_NAME="$1"
          KEY_PATH="$HOME/.ssh/$KEY_NAME"
          cat "$KEY_PATH.pub" | clipboard
          echo "Key copied to clipboard"
        }

      function makerole() {
      	mkdir -p "roles/$1/tasks"
      	mkdir -p "roles/$1/defaults"
      	touch "roles/$1/tasks/main.yml"
      	touch "roles/$1/defaults/main.yml"
      }
    '';
  };

  home.sessionPath = [
    "$HOME/.config/composer/vendor/bin"
  ];
}

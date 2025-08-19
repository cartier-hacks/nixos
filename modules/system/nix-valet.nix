/*
  This module gives the same functionality as laravel valet or valet linux.

  Set up DNSMasq to point all *.test domains to caddy.

  Caddy will look for a folder with the same name in ~/projects and serve it.
*/
{
  config,
  pkgs,
  lib,
  ...
}:

{
  services = {
    # Enable dnsmasq
    dnsmasq = {
      enable = true;
      settings = {
        # Point all .test domains to localhost
        address = "/.test/127.0.0.1";
        # Don't forward .test queries to upstream DNS
        # server = "/test/";
        # Listen on localhost only
        listen-address = "127.0.0.1";
        # Bind to interface
        bind-interfaces = true;
        # Cache size
        cache-size = 1000;
        # Don't read /etc/hosts
        no-hosts = true;
        # Don't poll /etc/resolv.conf
        no-poll = true;
      };
    };

    # Enable PHP-FPM
    # phpfpm = {
    #   pools.www = {
    #     user = "cartier";
    #     group = "users";
    #     settings = {
    #       "listen.owner" = "cartier";
    #       "listen.group" = "users";
    #       "listen.mode" = "0660";
    #       "pm" = "dynamic";
    #       "pm.max_children" = 32;
    #       "pm.start_servers" = 2;
    #       "pm.min_spare_servers" = 2;
    #       "pm.max_spare_servers" = 4;
    #       "pm.max_requests" = 500;
    #     };
    #     phpEnv."PATH" = lib.makeBinPath [ pkgs.php ];
    #   };
    # };

    # Enable Caddy
    caddy = {
      enable = true;
      package = pkgs.frankenphp;
      globalConfig = ''
        auto_https off
        frankenphp
        debug
        order php_server before file_server 
      '';
      /*
        WORKING CONFIG
            map {host} {pname} {
              ~^(.+)\.test$ $1
              default "unknown"
            }
            root * /home/cartier/projects/{pname}/public

            # Add file server directive with browse enabled for debugging
            file_server browse

            # Or for PHP apps, add try_files
            try_files {path} {path}/ /index.php?{query}

            php_server
      */
      extraConfig = ''
        # Specific subdomain first (more specific routes come first)
        http://caddytest.test {
            respond "fuck"
        }

        http://*.test, http://*.*.test {
          map {host} {project_dir} {
            ~^(.+)\.test$ $1
            default "unknown"
          }

          vars base_path "/home/cartier/projects/{project_dir}"

          @laravel file {
              root {vars.base_path}/public
              try_files index.php
          }

          @jigsaw file {
              root {vars.base_path}/build_local
              try_files index.html
          }

          handle @laravel {
            root * {vars.base_path}/public
            php_server
            file_server

            try_files {path} {path}/ /index.php?{query}
          }

          handle @jigsaw {
              root * {vars.base_path}/build_local
              try_files {path} {path}/ /index.html
              file_server
          }

          handle {
            respond "Unknown project type"
          }
        }
      '';
    };

    # Configure system to use local dnsmasq for .test domains
    resolved = {
      enable = true;
      domains = [ "~test" ];
      fallbackDns = [
        "10.89.0.1"
        # "8.8.8.8"
        # "1.1.1.1"
      ];
      extraConfig = ''
        DNS=127.0.0.1#53
        Domains=~test
        DNSSEC=false
      '';
    };
  };

  # Install PHP and related packages
  environment.systemPackages = with pkgs; [
    # Add common PHP extensions you might need
    php84Extensions.mbstring
    php84Extensions.xml
    php84Extensions.curl
    php84Extensions.zip
    php84Extensions.gd
    php84Extensions.intl
    php84Extensions.bcmath
    php84Extensions.soap
    php84Extensions.mysqli
    php84Extensions.pdo_mysql
    php84Extensions.pgsql
    php84Extensions.pdo_sqlite
  ];

  # Create a dedicated caddy config directory
  systemd.tmpfiles.rules = [
    "d /var/lib/caddy 0755 cartier users -"
  ];

  systemd.services.caddy = {
    serviceConfig = {
      User = lib.mkForce "cartier";
      Group = lib.mkForce "users";

      ProtectHome = lib.mkForce false; # This is key!
      ProtectSystem = lib.mkForce false;
      PrivateTmp = lib.mkForce false;

      # More comprehensive capabilities
      AmbientCapabilities = [
        "CAP_NET_BIND_SERVICE"
        "CAP_SETUID"
        "CAP_SETGID"
      ];
      CapabilityBoundingSet = [
        "CAP_NET_BIND_SERVICE"
        "CAP_SETUID"
        "CAP_SETGID"
      ];
      # Keep it simple - just set the config directory
      Environment = [ "XDG_CONFIG_HOME=/var/lib/caddy" ];
      # Ensure the working directory is accessible
      WorkingDirectory = "/var/lib/caddy";
    };
  };

  # And make sure your user is in the caddy group
  users.users.cartier = {
    extraGroups = [
      "users"
    ];
  };
}

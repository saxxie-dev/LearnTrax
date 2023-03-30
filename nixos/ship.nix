# Shipnix recommended settings
# IMPORTANT: These settings are here for ship-nix to function properly on your server
# Modify with care

{ config, pkgs, modulesPath, lib, ... }:
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
    '';
    settings = {
      trusted-users = [ "root" "ship" "nix-ssh" ];
    };
  };

  programs.git.enable = true;
  programs.git.config = {
    advice.detachedHead = false;
  };

  services.openssh = {
    enable = true;
    # ship-nix uses SSH keys to gain access to the server
    # Manage permitted public keys in the `authorized_keys` file
    passwordAuthentication = false;
    #  permitRootLogin = "no";
  };


  users.users.ship = {
    isNormalUser = true;
    extraGroups = [ "wheel" "nginx" ];
    # If you don't want public keys to live in the repo, you can remove the line below
    # ~/.ssh will be used instead and will not be checked into version control. 
    # Note that this requires you to manage SSH keys manually via SSH,
    # and your will need to manage authorized keys for root and ship user separately
    openssh.authorizedKeys.keyFiles = [ ./authorized_keys ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzAdg3lMof3PAk1UxQhRyL9gJmDhQne0yx35Pt8HJDqbQOpDKv4jjXDFv44UvK3tYicGdDZOaGv2seIvtZVHARKIBq9OSNxgLyxuxXbxIvPBvNvfflWrnItVHf3DXqy1SV0jfZ7q+zue92vcgcHyBzD82PCvToYu66sKuVttRFpO7KN1eU149k4axAEkvxR+PFsypylna3SK+kqCxTga6DxItKfAjWQYED8H7NNmUMSphAlnIB3elGc+ByWe3i3NPz+MssXSp+asjiRAC+kISlQrAO9g9XO8cOn8WmuIpPAIs7bbDyNhiP1bhB6VjAyHctoSDOXBUOXg83+yLqmt3wOjDeIkeHfGlUSlfkwrlIz4svLMbFBraoqxWswG5dUOMUuWnqvioITkLFVUFqTHlVk613+ep3Psrhyn9MzaNEZLX38Qiq+LvwujY8P1xqo2b4fvjngsytQyktcGYdgbL+pgFqRGXb8UBWXQ1k+lIhFUwuF2eQe4Wsd2UwLgCEki8= ship@tite-ship
"
    ];
  };

  # Can be removed if you want authorized keys to only live on server, not in repository
  # Se note above for users.users.ship.openssh.authorizedKeys.keyFiles
  users.users.root.openssh.authorizedKeys.keyFiles = [ ./authorized_keys ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzAdg3lMof3PAk1UxQhRyL9gJmDhQne0yx35Pt8HJDqbQOpDKv4jjXDFv44UvK3tYicGdDZOaGv2seIvtZVHARKIBq9OSNxgLyxuxXbxIvPBvNvfflWrnItVHf3DXqy1SV0jfZ7q+zue92vcgcHyBzD82PCvToYu66sKuVttRFpO7KN1eU149k4axAEkvxR+PFsypylna3SK+kqCxTga6DxItKfAjWQYED8H7NNmUMSphAlnIB3elGc+ByWe3i3NPz+MssXSp+asjiRAC+kISlQrAO9g9XO8cOn8WmuIpPAIs7bbDyNhiP1bhB6VjAyHctoSDOXBUOXg83+yLqmt3wOjDeIkeHfGlUSlfkwrlIz4svLMbFBraoqxWswG5dUOMUuWnqvioITkLFVUFqTHlVk613+ep3Psrhyn9MzaNEZLX38Qiq+LvwujY8P1xqo2b4fvjngsytQyktcGYdgbL+pgFqRGXb8UBWXQ1k+lIhFUwuF2eQe4Wsd2UwLgCEki8= ship@tite-ship
"
  ];

  security.sudo.extraRules = [
    {
      users = [ "ship" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" "SETENV" ];
        }
      ];
    }
  ];
}

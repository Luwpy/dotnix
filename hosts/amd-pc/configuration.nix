{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
  };
  boot.loader.grub.extraEntries = ''
    menuentry "Windows Boot Manager" {
      insmod part_msdos
      insmod ntfs
      set root=(hd1,msdos1)  # hd1 = /dev/sdb, msdos1 = partition 1
      chainloader +1
    }
  '';


  services.openssh.enable = true;

  networking.hostName = "amd-pc";

  time.timeZone = "America/Sao_Paulo";

  system.stateVersion = "24.05"; # Did you read the comment?

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      {
        file = "/var/keys/secret_file";
        parentDirectory = {mode = "u=rwx,g=,o=";};
      }
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["flakes" "nix-command"];

  environment.systemPackages = with pkgs; [
    helix
    zed-editor
    alejandra
    nixd
    vscode
    discord
    vesktop
    ventoy-full
    kitty
    wofi
    rofi
    firefox

    pavucontrol

    quickemu
    qemu

    mesa

    openssl
    wl-clipboard
    spotify-cli-linux
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  programs.git.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };

  # USUÁRIO
  luwpy.enable = true;

  # Perfis
  gaming.enable = true;

  programs.fuse.userAllowOther = true;

  greeter.greetd.enable = true;
}

{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable AMD microcode updates for the processor
  boot.kernelModules = ["amdgpu"];
  boot.kernelParams = ["amd_pstate=guided"];

  hardware.cpu.amd.updateMicrocode = true;

  # Enable support for AMD GPUs

  hardware.graphics = {
    enable = true;

    enable32Bit = true; # Enable 32-bit support for graphics applications
  };

  # Optional: Enable Vulkan support for AMD GPUs
  hardware.graphics.extraPackages = with pkgs; [
    vulkan-loader
    vulkan-tools
    amdvlk
    mesa
  ];
}

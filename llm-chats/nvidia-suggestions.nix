{ config, pkgs, ... }: {
  # NVIDIA GPU configuration
  hardware = {
    nvidia = {
      # Specific for RTX 3060 series
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      open = false; # Proprietary driver recommended
      
      # Power management for eGPU
      powerManagement.enable = true;
    };

    # Graphics configuration
    graphics = {
      enable = true;
      enable32Bit = true;
      
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  # X11 Configuration
  services.xserver = {
    videoDrivers = [ "nvidia" "intel" ];
  };

  # CUDA and NVIDIA support
  programs = {
    cuda.enable = true;
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
    # Optionally add CUDA-enabled applications
    cudnn
  ];
}

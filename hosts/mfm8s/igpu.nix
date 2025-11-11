{ pkgs, ... }:

{
  # REF: Traced from nixos-hardware/common/cpu/intel/alder-lake
  # and wiki.nixos.org/wiki/Intel_Graphics

  boot.initrd.kernelModules = [ "i915" ];

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver            # Hardware Acceleration
    intel-compute-runtime         # OpenCL & oneAPI Level Zero
    vpl-gpu-rt                    # Quick Sync Video
    # intel-vaapi-driver
    # intel-ocl
  ];

  hardware.graphics.extraPackages32 = with pkgs.driversi686Linux; [
   intel-media-driver
   intel-vaapi-driver
  ];

  # NOTE: https://wiki.archlinux.org/title/Hardware_video_acceleration#Configuring_VA-API
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # NOTE: Grant btop the ability to query intel gpu usage info
  # REF: https://github.com/nixos/nixpkgs/issues/424986
  # and the `hardware.intel-gpu-tools` module
  security.wrappers.btop = {
    owner = "root";
    group = "root";
    source = "${pkgs.btop}/bin/btop";
    capabilities = "cap_perfmon+ep";
  };
}

{ ... }:

{
  # Enable zswap, see available params at /sys/module/zswap/parameters/
  # DOC: https://docs.kernel.org/admin-guide/mm/zswap.html
  # TODO: Try out the new zswap module `boot.zswap`
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.shrinker_enabled=1"
  ];
}

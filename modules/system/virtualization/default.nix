{
  config,
  pkgs,
  lib,
  ...
}:

{
  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
    "vfio-pci.ids=10de:28e0,10de:22be"
    "modprobe.blacklist=nouveau"
    "kvmfr.static_size_mb=64"
  ];

  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    "kvmfr"
    "amdgpu"
  ];

  boot.extraModulePackages = [
    config.boot.kernelPackages.kvmfr
  ];

  boot.kernelModules = [
    "kvm"
    "kvm_amd"
    "vhost-net"
  ];

  boot.extraModprobeConfig = ''
    options kvm_amd nested=1
    options kvm ignore_msrs=1
    options kvm report_ignored_msrs=1
  '';

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
    extraConfig = ''
      uri_default = "qemu:///system"
    '';
    qemu.verbatimConfig = ''
      namespaces = []
      cgroup_device_acl = [
        "/dev/null", "/dev/full", "/dev/zero",
        "/dev/random", "/dev/urandom",
        "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
        "/dev/rtc", "/dev/hpet", "/dev/vfio/vfio",
        "/dev/kvmfr0"
      ]
    '';
  };

  programs.virt-manager.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  services.udev.packages = lib.singleton (
    pkgs.writeTextFile {
      name = "kvmfr";
      text = ''
        SUBSYSTEM=="kvmfr", GROUP="kvm", MODE="0660", TAG+="uaccess"
      '';
      destination = "/etc/udev/rules.d/70-kvmfr.rules";
    }
  );

  users.users.yjc.extraGroups = [
    "libvirtd"
    "kvm"
    "input"
    "disk"
  ];

  environment.systemPackages = with pkgs; [
    virt-viewer
    guestfs-tools
    usbutils
    dmidecode
    bridge-utils
    virtiofsd
    virtio-win
    looking-glass-client
  ];
}

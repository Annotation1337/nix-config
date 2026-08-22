{ config, pkgs, lib, ... }:

{
  # ==============================================================
  # 内核参数: AMD IOMMU + VFIO 设备绑定
  # ==============================================================
  boot.kernelParams = [
    # 启用 AMD-Vi (IOMMU) — PCI 直通的前提
    "amd_iommu=on"
    # IOMMU 透传模式 — 未直通设备用 1:1 映射, 减少宿主机开销
    "iommu=pt"
    # VFIO 接管 RTX 4060 (VGA + HDMI Audio)
    "vfio-pci.ids=10de:28e0,10de:22be"
    # 禁用 nouveau 开源驱动, 防止它抢占 GPU
    "modprobe.blacklist=nouveau"
    # Looking Glass kvmfr 模块 — 预留 64MB 共享内存
    # (1080p 约 32MB, 1440p 约 64MB, 4K 约 128MB)
    "kvmfr.static_size_mb=64"
  ];

  # ==============================================================
  # initrd 内核模块 (启动早期加载, 顺序很重要!)
  # ==============================================================
  boot.initrd.kernelModules = [
    # VFIO 三件套 — 必须在显卡驱动之前加载, 才能抢到 GPU
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    # Looking Glass 内核模块 (KVMFR)
    "kvmfr"
    # 宿主机 AMD 显卡驱动 — 在 VFIO 之后加载
    "amdgpu"
  ];

  # ==============================================================
  # 额外内核模块包
  # ==============================================================
  boot.extraModulePackages = [
    # Looking Glass 的 kvmfr 内核模块
    config.boot.kernelPackages.kvmfr
  ];

  # ==============================================================
  # 常规内核模块
  # ==============================================================
  boot.kernelModules = [
    "kvm"
    "kvm_amd"
    "vhost-net"     # virtio 网络加速
  ];

  # ==============================================================
  # KVM 模块参数调优
  # ==============================================================
  boot.extraModprobeConfig = ''
    # 嵌套虚拟化 (VM 内再跑 VM / WSL2 / Docker)
    options kvm_amd nested=1
    # 忽略未知 MSR 读取 — 游戏 VM 兼容性必备
    options kvm ignore_msrs=1
    options kvm report_ignored_msrs=1
  '';

  # ==============================================================
  # libvirtd / QEMU 主配置
  # ==============================================================
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      # 使用 KVM 加速版 QEMU
      package = pkgs.qemu_kvm;
      # 以 root 运行 QEMU — PCI 直通必需
      runAsRoot = true;
      # TPM 2.0 模拟 — Windows 11 必需
      swtpm.enable = true;
      # 注意: NixOS 25.11+ 移除了 qemu.ovmf 选项
      # OVMF (UEFI 固件) 现在随 QEMU 自动分发, 无需手动启用
      # 路径: /run/libvirt/nix-ovmf/edk2-x86_64-code.fd
    };
    # 默认使用 system 连接 (所有用户共享)
    extraConfig = ''
      uri_default = "qemu:///system"
    '';
    # Looking Glass: 将 kvmfr 设备加入 QEMU cgroup 白名单
    # (配置写入 qemu.conf)
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

  # ==============================================================
  # virt-manager 图形管理
  # ==============================================================
  programs.virt-manager.enable = true;

  # SPICE USB 重定向
  virtualisation.spiceUSBRedirection.enable = true;

  # ==============================================================
  # kvmfr 设备 udev 权限
  # ==============================================================
  services.udev.packages = lib.singleton (pkgs.writeTextFile {
    name = "kvmfr";
    text = ''
      SUBSYSTEM=="kvmfr", GROUP="kvm", MODE="0660", TAG+="uaccess"
    '';
    destination = "/etc/udev/rules.d/70-kvmfr.rules";
  });

  # ==============================================================
  # 用户组
  # ==============================================================
  users.users.yjc.extraGroups = [
    "libvirtd"   # libvirt 管理权限 (免 sudo)
    "kvm"        # /dev/kvm 和 kvmfr 设备访问
    "input"      # 输入设备权限 (Looking Glass / USB 直通)
    "disk"       # 磁盘访问权限
  ];

  # ==============================================================
  # 额外工具包
  # ==============================================================
  environment.systemPackages = with pkgs; [
    # 虚拟机工具
    virt-viewer        # SPICE/VNC 查看器
    guestfs-tools      # 磁盘镜像工具集 (virt-builder, virt-sysprep 等)

    # 调试工具
    usbutils           # lsusb
    dmidecode          # DMI 硬件信息

    # 网络/网桥
    bridge-utils       # brctl

    # virtio 驱动
    virtiofsd          # virtio-fs 守护进程 (主机-虚拟机文件共享)
    virtio-win         # Windows virtio 驱动 ISO

    # Looking Glass 客户端 (超低延迟 VM 画面传输)
    looking-glass-client
  ];

  # ==============================================================
  # 防火墙 (你的配置已关闭防火墙, 此项留作参考)
  # 如果之后开启防火墙, 需要信任 libvirt 默认网桥
  # ==============================================================
  # networking.firewall.trustedInterfaces = [ "virbr0" ];
}


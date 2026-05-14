{ lib, stdenv, kernel }:

stdenv.mkDerivation {
  pname = "fl2000_drm";
  version = "ed5a85be613f6711750772b0628c050655f82e79";

  src = lib.cleanSourceWith {
    src = ./.;
    filter = path: type:
      let
        baseName = builtins.baseNameOf (toString path);
      in
      lib.cleanSourceFilter path type && !(
        lib.hasSuffix ".o" baseName
        || lib.hasSuffix ".ko" baseName
        || lib.hasSuffix ".mod" baseName
        || lib.hasSuffix ".mod.c" baseName
        || lib.hasSuffix ".mod.o" baseName
        || lib.hasSuffix ".cmd" baseName
        || baseName == "Module.symvers"
        || baseName == "modules.order"
        || baseName == ".tmp_versions"
      );
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  hardeningDisable = [ "pic" "format" ];
  dontStrip = true;

  makeFlags = [
    "KVER=${kernel.modDirVersion}"
    "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  buildFlags = [ "modules" ];

  installPhase = ''
    runHook preInstall

    install -Dm644 fl2000.ko $out/lib/modules/${kernel.modDirVersion}/extra/fl2000.ko
    install -Dm644 it66121.ko $out/lib/modules/${kernel.modDirVersion}/extra/it66121.ko

    runHook postInstall
  '';

  meta = with lib; {
    description = "Fresco Logic FL2000DX and IT66121 out-of-tree DRM kernel modules";
    homepage = "https://github.com/klogg/fl2000_drm";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}

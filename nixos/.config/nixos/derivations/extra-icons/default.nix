{ lib
, pkgs
, stdenv
, fetchurl
}:

stdenv.mkDerivation rec {
  pname = "extra-icons";
  version = "0.0.1";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    imagemagick # for resize
    inkscape # for svgs
  ];

  postInstall = ''
    mkdir -p $out/share/icons/hicolor/scalable/apps/
    for icon in ${src}/raster/*; do
      icon_name=$(basename "$icon")
      inkscape -p "$icon" -o "$out/share/icons/hicolor/scalable/apps/extra-scale-''${icon_name%.*}.svg"
      for i in 16 24 48 64 96 128 256 512; do
        mkdir -p $out/share/icons/hicolor/''${i}x''${i}/apps
        magick convert -background none -resize "''${i}x''${i}" "$icon" "$out/share/icons/hicolor/''${i}x''${i}/apps/extra-$icon_name"
      done
    done
    for icon in ${src}/vector/*; do
      icon_name=$(basename "$icon")
      cp "$icon" "$out/share/icons/hicolor/scalable/apps/extra-scale-$icon_name"
      inkscape -p "$icon" -o "$out/share/icons/hicolor/scalable/apps/extra-''${icon_name%.*}-svg.svg"
    done
  '';
}


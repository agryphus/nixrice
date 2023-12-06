{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lf

    atool # Provides aunpack, to open archives.  Also can list archive contents.
    bat # A prettified 'cat'
    broot # A slicker fzf
    chafa # Display images in the terminal (supports sixel)
    ffmpegthumbnailer # Get thumbnails of videos
    file # Get information about a specific file
    fzf # Fuzzy finder.  Might fully replace with broot
    imagemagick # Image conversion/processing tool
    mediainfo # Get info about media
    mpv # Audio and video player
    nsxiv # Image viewer
    odt2txt # Convert open documents to text
    perl536Packages.FileMimeInfo # Provides mimeopen, to ask what program to open files in
    poppler_utils # Provides pdftoppm, to turn pdfs into images
    unrar-wrapper # Extract .rar files
    xclip # Copy file name to clip
    zathura # PDF viewer
  ];
}


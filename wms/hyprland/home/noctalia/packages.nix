{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    tesseract # for ocr
    ffmpeg # for screen recording
    mpv
    bc
    # wl-screenrec
    wf-recorder
    gifski
    # gpu-screen-recorder
  ];

}

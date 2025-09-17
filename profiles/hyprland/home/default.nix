{
  inputs,
  ...
}:
let
  userModule = import ../../../util/homeConfig.nix;
in
{
  imports = [
    (userModule {
      inherit inputs;
      username = "rick";
      homeFile = ./home.nix;
    })
  ];
}

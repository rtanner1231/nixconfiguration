{ profile, wm, ... }:
{

  environment.sessionVariables = {
    NIXPROFILE = profile.name;
    NIXWM = wm;
  };
}

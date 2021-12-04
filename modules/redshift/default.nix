{
  home-manager.users.jobo.services.redshift = {
    enable = true;
    provider = "manual";
    latitude = 52.237049;
    longitude = 21.017532;
    temperature = {
      day = 5700;
      night = 2700;
    };
  };
}

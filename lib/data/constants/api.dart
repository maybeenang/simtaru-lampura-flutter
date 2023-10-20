class Endpoints {
  // static String baseURL = "https://simtaru-lampura.com/api/v1/";
  static String baseURL = "https://daring-asp-immortal.ngrok-free.app/api/v1/";
  // static String baseURLDownload = "https://simtaru-lampura.com";
  static String baseURLDownload = "https://daring-asp-immortal.ngrok-free.app";
  static String login = "auth/login";
  static String logout = "auth/logout";
  static String register = "auth/register";
  static String profile = "auth/me";
  static String refresh = "auth/refresh";
  static String seluruhPengajuan = "pengajuan/seluruh";
  static String pengajuanByStatus = "pengajuan/status/";
  static String pengajuanJumlah = "pengajuan/hitungData";
  static String statusPengajuan = "status/getAll";
  static String userPengajuan = "pengajuan/user/";
  static String convertDownloadUrl(String url) {
    return baseURLDownload + url;
  }

  static String weatherEndpoint =
      "https://api.weatherapi.com/v1/current.json?key=0635e5c87e24430ca0041614220607&q=-4.813390,104.752094";
}

class Endpoints {
  // static String baseURL = "https://www.simtaru-lampura.com/api/v1/";
  static String baseURL = "https://raccoon-concrete-simply.ngrok-free.app/api/v1/";
  // static String baseURL = "https://relieved-cheaply-drum.ngrok-free.app/api/v1/";
  // static String baseURLDownload = "https://www.simtaru-lampura.com";
  static String baseURLDownload = "https://raccoon-concrete-simply.ngrok-free.app";
  // static String baseURLDownload = "https://relieved-cheaply-drum.ngrok-free.app";
  static String peta = "https://www.simtaru-lampura.com/peta";

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
  static String tambahPengajuan = "pengajuan/tambah";
  static String updateStatusPengajuan = "pengajuan/status/updateStatus/";
  static String updatePengajuan = "pengajuan/edit/";
  static String updatePolygonPengajuan = "pengajuan/updatePolygon/";
  static String editDataLapangan = "pengajuan/verifikasiLapangan/";
  static String editFilePengajuan = "pengajuan/edit/";
  static String deleteFilePengajuan = "pengajuan/delete/";
  static String getAllUser = "user/getAll";
  static String editUser = "user/edit/";
  static String tambahUser = "user/createUser";
  static String hapusUser = "user/delete/";
  static String getAllArtikel = "artikel/getAll";
  static String createArtikel = "artikel/create";
  static String editArtikel = "artikel/edit/";
  static String deleteArtikel = "artikel/delete/";
  static String getAllRole = "user/getAllRole";
  static String getAllNotif = "notif/getAll";

  static String convertDownloadUrl(String url) {
    return baseURLDownload + url;
  }

  static String weatherEndpoint =
      "https://api.weatherapi.com/v1/current.json?key=0635e5c87e24430ca0041614220607&q=-4.813390,104.752094";

  static String gmapsUrl = "https://www.google.com/maps/search/?api=1&query=";
}

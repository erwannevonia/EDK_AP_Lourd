class AppData {
  static String? userId;
  static String? userName;

  static bool isUserValid() {
    return userId != null && userName != null;
  }
}
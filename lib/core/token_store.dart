/// Almacén de token en memoria para el interceptor Dio.
/// Complementa flutter_secure_storage, que en Linux requiere
/// un servicio de llaves (kwallet/gnome-keyring) que puede no estar disponible.
class TokenStore {
  TokenStore._();

  static String? _access;
  static String? _refresh;

  static String? get access => _access;
  static String? get refresh => _refresh;

  static void setAccess(String? token) => _access = token;
  static void setRefresh(String? token) => _refresh = token;

  static void clear() {
    _access = null;
    _refresh = null;
  }
}

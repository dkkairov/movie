import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _keys {
  static const sessionId = 'session-id';
}

class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getSessionId() => _secureStorage.read(key: _keys.sessionId);
  Future<void> setSessionId(String value) => _secureStorage.write(key: _keys.sessionId, value: value);
}
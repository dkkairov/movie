import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _keys {
  static const sessionId = 'session-id';
  static const accountId = 'account-id';
}

class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getSessionId() => _secureStorage.read(key: _keys.sessionId);
  Future<void> setSessionId(String? value) {
    if(value != null){
      return _secureStorage.write(key: _keys.sessionId, value: value);
    } else {
      return _secureStorage.delete(key: _keys.sessionId);
    }
  }

  Future<int?> getAccountId() async {
    final id = await _secureStorage.read(key: _keys.accountId);
    return id != null ? int.tryParse(id) : null;
  }
  Future<void> setSAccountId(int? value) {
    if(value != null){
      return _secureStorage.write(
          key: _keys.accountId,
          value: value.toString()
      );
    } else {
      return _secureStorage.delete(key: _keys.accountId);
    }
  }
}
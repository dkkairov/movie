import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie/domain/api_client/api_client.dart';
import 'package:movie/domain/data_providers/session_data_provider.dart';
import 'package:movie/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage = null;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;


  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Enter login and password';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(
          username: login, password: password
      );
    } on ApiClientException catch(e) {
      switch (e.type) {
        case ApiClientExceptionType.Network:
          _errorMessage = 'Server is not available. Please check internet connection.';
          break;
        case ApiClientExceptionType.Auth:
          _errorMessage = 'Incorrect login or password.';
          break;
        case ApiClientExceptionType.Other:
          _errorMessage = 'Error. Please try again.';
          break;
      }
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null) {
      _errorMessage = 'Please try later';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }

}


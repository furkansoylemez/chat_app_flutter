import 'dart:ui';

class AppConstants {
  AppConstants._();

  /// App Constants
  static const Duration splashDuration = Duration(seconds: 3);
  static const int passwordMinLength = 8;
  static const int displayNameMinLength = 5;
  static const Locale defaultLocale = Locale('tr');

  /// Collection names
  static const String usersCollection = 'users';
  static const String conversationsCollection = 'conversations';
  static const String messagesCollection = 'messages';
  static const String timestampField = 'timestamp';

  /// Storage keys
  static const String isLightThemeKey = 'isLightTheme';

  /// Socket Constants
  //static const String localSocketUrl = 'http://10.0.2.2:3000';
  static const String localSocketUrl =
      'https://melodious-awake-watercress.glitch.me/';
  static const String socketTransport = 'websocket';

  /// Socket Events
  static const String newMessageEvent = 'newMessage';
  static const String sendMessageEvent = 'sendMessage';
  static const String userOnlineEvent = 'userOnline';
  static const String userOfflineEvent = 'userOffline';
  static const String userTypingEvent = 'userTyping';
  static const String userTypingEndEvent = 'userTypingEnd';
  static const String requestUserOnlineStatusEvent = 'requestUserOnlineStatus';
}

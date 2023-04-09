class AppConstants {
  /// App Constants
  static const Duration splashDuration = Duration(seconds: 3);
  static const int passwordMinLength = 8;
  static const int displayNameMinLength = 5;

  /// App Constants

  /// Collection names
  static const String usersCollection = 'users';
  static const String conversationsCollection = 'conversations';
  static const String messagesCollection = 'messages';
  static const String timestampField = 'timestamp';

  /// Collection names

  /// Storage keys
  static const String isLightThemeKey = 'isLightTheme';

  /// Storage keys

  /// Socket Constants
  static const String localSocketUrl = 'http://10.0.2.2:3000';
  static const String socketTransport = 'websocket';

  /// Socket Constants

  /// Socket Events
  static const String newMessageEvent = 'newMessage';
  static const String sendMessageEvent = 'sendMessage';
  static const String userOnlineEvent = 'userOnline';
  static const String userOfflineEvent = 'userOffline';
  static const String userTypingEvent = 'userTyping';
  static const String userTypingEndEvent = 'userTypingEnd';
  static const String requestUserOnlineStatusEvent = 'requestUserOnlineStatus';
}

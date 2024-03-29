class ApiEndPoints {
  static final String baseUrl = 'http://52.139.152.154/api/v1/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String loginEmail = 'auth/login';
  final String refresh = 'auth/refresh';
  final String forgot = 'auth/forgot-password';
  final String resetPassword = 'auth/reset-password';
  final String changePassword = 'auth/change-password';
  final String posts = 'posts';
  final String comments = 'comments';
  final String replies = 'replies';
  final String forums = 'forums';
  final String profile = 'users/profile';
  final String user = 'users/';
  final String notifications = 'notifications';
  final String search = 'search=';
  final String myFriends = 'friends/me';
  final String friendRequests = 'friends';
  final String getUser = 'users';
  final String events = 'events';
  final String getConversations = 'conversations';
}

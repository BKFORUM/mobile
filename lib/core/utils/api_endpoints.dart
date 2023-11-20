class ApiEndPoints{
  static final String baseUrl = 'http://52.139.152.154/api/v1/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}
class _AuthEndPoints{
  final String loginEmail = 'auth/login';
  final String posts = 'posts';
  final String comments = 'comments';
  final String forums = 'forums';
  final String profile = 'users/profile';
  final String notifications = 'notifications';
}
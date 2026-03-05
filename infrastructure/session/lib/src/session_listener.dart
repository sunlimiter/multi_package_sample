import 'session_manager.dart';

abstract class SessionStateChangedListener {
  void onUserInfoChanged(SessionManager manager);
  void onTokenInfoChanged(SessionManager manager);
}

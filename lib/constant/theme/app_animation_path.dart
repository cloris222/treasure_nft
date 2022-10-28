class AppAnimationPath {
  const AppAnimationPath._();

  /// animation path
  static const String animationPathJson = 'assets/animation';

  /// trade animation
  static const String reserveSuccess =
      '$animationPathJson/reserve_success_01.json';
  static const String rotating = '$animationPathJson/icon_rotate_gradient.json';
  static const String beginnerReserving =
      '$animationPathJson/icon_rotate_blue.json';

  ///登入後的招呼動畫
  static const String loginMorning = '$animationPathJson/mb_login_morning.json';
  static const String loginAfternoon =
      '$animationPathJson/mb_login_afternoon.json';
  static const String loginNight = '$animationPathJson/mb_login_night.json';

  /// 註冊成功動畫
  static const String registerSuccess =
      '$animationPathJson/mb_signup_success_01.gif';

  /// reservation animation
  static const String reservationAnimation =
      '$animationPathJson/mb_level_{index}.gif';

  /// achievement_unlock
  static const String achievementUnlockAnimation =
      '$animationPathJson/achievement_unlocked_01_all.json';
}

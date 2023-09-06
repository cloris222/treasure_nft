class AppAnimationPath {
  const AppAnimationPath._();

  /// animation path
  static const String animationPathJson = 'assets/animation';

  /// trade animation
  static const String reserveSuccess = 'reserve_success_01.json';
  static const String rotating = 'icon_rotate_gradient.json';
  static const String beginnerReserving = 'icon_rotate_blue.json';

  ///登入後的招呼動畫
  // static const String loginMorning = 'mb_login_morning.json';
  // static const String loginAfternoon = 'mb_login_afternoon.json';
  // static const String loginNight = 'mb_login_night.json';
  static const String loginAnimation = 'a_miaopai_mb_login.json';

  /// 註冊成功動畫
  /// v2.1.2_729 移除註冊動畫
  static const String registerSuccess =
      '$animationPathJson/mb_signup_success_01.gif';

  /// reservation animation
  static const String reservationAnimation = 'mb_level_{index}.gif';
  static const String reservationDice3D = 'lv{level}_{size}px.gif';

  /// achievement_unlock
  static const String achievementUnlockAnimation =
      'achievement_unlocked_01_all.json';

  /// 購買成功
  static const String buyNFTSuccess = 'purchased_successfully_all.json';
  /// 等待購買
  static const String buyNFTLoading = '$animationPathJson/reservation_loading.json';

  /// 等級提升
  static const String showLevelUp = 'levelup_01_all.json';
  static const String arrow = '$animationPathJson/icon_arrow_01.png';

  /// 儲金罐
  static const String showCoinJar = 'coin_jar_01.json';

  /// 開賣動畫
  static const String showWaitSell = 'mb_announce_01.json';

  /// 收藏開啟翅膀盲盒
  static const String showOpenWinsBox = 'box_open_wings.json';

  /// 啟動頁動畫
  static const String splashScreen =
      '$animationPathJson/logo_start_animation.mp4';

  /// 活動預約成功
  static const String activitySuccess = 'confetti_transparent.gif';
  static const String airdropOpen="$animationPathJson/box_open_lv{level}_01.gif";
  static const String airdropWait="$animationPathJson/box_open_lv{level}_02.gif";
}

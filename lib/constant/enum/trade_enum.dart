enum LevelRank {
  LEVEL0,
  LEVEL1,
  LEVEL2,
  LEVEL3,
  LEVEL4,
  LEVEL5,
  LEVEL6,
  LEVEL7,
  LEVEL8,
  LEVEL9,
  LEVEL10,
}

enum SellingState {
  /// 尚未開賣
  NotYet,

  /// 預約中
  Reserving,


  ///預約結束
  End,
}

enum ActivityState {
  Activity, //預約時間（顯示button)
  HideButton, // 隱藏預約button
  End // 顯示中獎名單
}

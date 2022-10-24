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

  /// 開賣中
  Selling,

  /// 預約中
  Reserving,
}

enum TaskType {
  ///每日任務
  daily,

  ///成就任務
  achieve,

  ///成就徽章
  medal
}

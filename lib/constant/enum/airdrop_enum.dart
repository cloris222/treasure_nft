enum AirdropType {
  ///預約獎勵
  dailyReward,

  /// 升級獎勵
  growthReward,

  ///獎金池
  soulPath
}

enum AirdropRewardType {
  ///空箱子
  EMPTY,

  /// 獎金
  MONEY,

  ///商品
  ITEM,

  /// 獎章
  MEDAL,
  ALL
}

enum BoxStatus {
  /// 無法開啟
  locked,

  /// 可開啟
  unlocked,

  /// 已開啟
  opened,
}

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

enum BoxAnimateStatus {
  ///箱子開啟中
  opening,

  ///箱子還有下一個
  next,

  ///開下一個箱子
  nexting,

  ///沒有箱子了
  noNext,

  ///顯示最後獎勵
  finish,
}

enum BoxType {
  RESERVE_BOX,
  LEVEL_BOX_1,
  LEVEL_BOX_2,
  LEVEL_BOX_3,
  LEVEL_BOX_4,
  LEVEL_BOX_5,
  LEVEL_BOX_6
}

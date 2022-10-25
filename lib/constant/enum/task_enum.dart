
enum TaskType {
  ///每日任務
  daily,

  ///成就任務
  achieve,

  ///成就徽章
  medal
}

enum TaskStatus {
  ///未達成
  notFinish,

  ///未領取
  unTaken,

  ///已領取
  isTaken
}

enum DailyCode {
  ///簽到
  DlySignIn,

  ///預約成功
  DlyRsvScs,

  ///購買成功
  DlyBuyScs,

  ///自己購買滿額
  DlySlfBuyAmt,

  ///團隊購買次數
  DlyTeamBuyFreq,

  ///團隊購買金額
  DlyTeamBuyAmt,

  ///邀請有效A級
  DlyInvClsA,

  ///邀請有效B或C級
  DlyInvClsBC,

  ///分享
  DlyShr
}
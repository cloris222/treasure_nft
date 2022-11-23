

class CardShowingData {

  CardShowingData({
    this.title = '',
    this.content = '',
    this.bIcon = false,
    this.bPrice = false
  });

  String title; // 將Title轉成多語化的key，方便顯示
  String content; // 原資料直接存進即可
  bool bIcon; // 是否顯示錢幣icon
  bool bPrice; // 是否為價格類型，是的話要做千分位跟小數點兩位的處理

}
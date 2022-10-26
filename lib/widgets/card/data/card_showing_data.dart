

class CardShowingData {

  CardShowingData({
    this.title = '',
    this.content = '',
    this.bIcon = false
  });

  String title; // 將Title轉成多語化的key，方便顯示
  String content; // 原資料直接存進即可
  bool bIcon; // 是否顯示錢幣icon

}


class CardShowingData {

  CardShowingData({
    required this.title,
    required this.content
  });

  final String title; // 將Title轉成多語化的key，方便顯示
  final String content; // 原資料直接存進即可

}
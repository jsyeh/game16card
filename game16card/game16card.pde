//看到網友林仕風的問題，要設計一個撲克牌遊戲，
//只用16牌，隨機洗牌，放成4x4矩陣，再翻牌
void setup(){
  size(400,400);
}
String []Face={"A","K","Q","J"};
String []Suit={"黑桃","紅心","紅磚","梅花"};
void draw(){
  background(255);
  textAlign(CENTER,CENTER);
  for(int i=0; i<4; i++){
    for(int j=0; j<4; j++){
      fill(255);
      rect(100*i, 100*j,100,100);
      fill(0);
      text(Suit[i]+Face[j], i*100+50,j*100+50);
    }
  }
}

//看到網友林仕風的問題，要設計一個撲克牌遊戲，
//只用16牌，隨機洗牌，放成4x4矩陣，再翻牌
void setup(){
  size(500,250);
}
String []Face={"A","K","Q","J"};
String []Suit={"黑桃","紅心","紅磚","梅花"};
void drawCard(String t, int i, int j){
  fill(255);
  rect(100+100*i, 50+50*j, 100,50);
  fill(0);
  text(t, 100+50+100*i, 50+25+50*j);
}//做出函式 drawCard()來簡化程式碼

void draw(){
  background(255);
  textAlign(CENTER,CENTER);
  for(int i=0; i<4; i++){
    drawCard(Face[i], -1, i);
    drawCard(Suit[i], i, -1);
  }
  
  for(int i=0; i<4; i++){
    for(int j=0; j<4; j++){
      drawCard(Suit[i]+Face[j], i,j);
    }
  }
}

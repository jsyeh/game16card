# game16card
設計一個撲克牌遊戲，只用16牌，隨機洗牌，放成4x4矩陣，再翻牌

## step01 先用字串畫出圖

寫程式時，第一步，先能確認可以將字串畫出來，開心！

![step01.png](figure/step01.png)

```processing
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
```

## step02 表格畫面
因為網友的圖是個表格，所以想要模仿做出表格。
發明 `drawCard()` 函式簡化程式，


![step02.png](figure/step02.png)

```processing
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
```

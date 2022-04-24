//作者：葉正聖 jsyeh@mail.mcu.edu.tw
//看到網友林仕風的問題，要設計一個撲克牌遊戲，
//只用16牌，隨機洗牌，放成4x4矩陣，再翻牌
//Step03: 解決之前 i,j 錯亂的問題,並加紅色
//       j=0黑桃 j=1紅心 j=2紅磚 j=3梅花 (x座標)
//i=0 A
//i=1 K
//i=2 Q
//i=3 J
//(y座標）
int [][]card=new int[4][4];//Step04 洗牌用的對照表
void setup(){
  size(610,360);
  for(int c=0; c<4*4; c++){
    card[int(c/4)][c%4] = c;
  }
}

void myShuffle(){//Step04 洗牌函式
  for(int k=0; k<1000; k++){
    int i=int(random(4)), j=int(random(4));
    int i2=int(random(4)), j2=int(random(4));
    int temp=card[i][j];
    card[i][j]=card[i2][j2];
    card[i2][j2]=temp;
  }
  arrowN=-1;//step05 重設箭頭
  for(int i=0; i<16; i++) used[i]=false;
}

String []Face={"A","K","Q","J"};//Face[i]
String []Suit={"黑桃","紅心","紅磚","梅花"};//Suit[j]

void drawCard(String t, int i, int j){
  fill(255);
  rect(100+100*j, 50+50*i, 100,50);
  //4x4的卡片區 適時字變紅色
  if(i>=0 && t.charAt(0)=='紅') fill(#ff0000);
  else fill(0);
  text(t, 100+50+100*j, 50+25+50*i);
}//step02: 做出函式 drawCard()來簡化程式碼

void draw(){
  background(255,255,191);//淡黃色背景
  strokeWeight(1);
  textAlign(CENTER,CENTER);
  for(int i=0; i<4; i++){
    drawCard(Face[i], i, -1);
  }
  for(int j=0; j<4; j++){
    drawCard(Suit[j], -1, j);
  }
  
  for(int i=0; i<4; i++){
    for(int j=0; j<4; j++){
      //step04: 將洗牌的結果 card[i][j] 換算出花色牌面
      int ii = int(card[i][j]/4), jj=card[i][j]%4;
      drawCard(Suit[jj]+Face[ii], i, j);
      if(used[i*4+j]==false){//step05 模擬時，沒用的牌半透明
        fill(255,128); rect(100+j*100,50+i*50,100,50);
      }
    }//step01: 先結合字串，以印出卡片花色＋牌面
  }
  
  noFill();//畫出右下角黑色大框，讓畫面重點更清楚
  strokeWeight(2);
  rect(100,50,400,200);
  
  if(arrowN!=-1){//step05 draw Arrow
    String line="";
    for(int i=0; i<arrowN; i++){
      int ii=int(arrow[i]/4), jj=arrow[i]%4;
      int c = card[ii][jj];
      line += " "+Suit[c%4]+Face[int(c/4)];
      if(i==arrowN-1) break;
      drawArrow( arrow[i], arrow[i+1] );
    }
    fill(0);text("你能翻"+arrowN+"張牌: "+line, 20,250, width-200,50);
  }
  drawCard("先洗牌", 5, 0);
  drawCard("開始玩", 5, 2);
}

void mousePressed(){//step05 模擬遊戲進行
  int i=int(mouseY/50)-1, j=int(mouseX/100)-1;
  if(i==5 && j==0) myShuffle();//先洗牌
  if(i==5 && j==2) genArrow();//開始玩
}

int [] arrow=new int[17];//arrow to the next card
int arrowN=-1;

boolean [] used=new boolean[16];//step05: 對應的格子有無走過
void genArrow(){//step05 用箭頭模擬遊戲進行
  for(int i=0; i<16; i++) used[i]=false;
  used[15]=true;//走過這張卡片
  arrow[0]=15;//右下角的卡片，存的是位置15
  arrowN=1;
  for(int i=0; i<16-1; i++){
    arrow[i+1] = nextCard(arrow[i]);
    if(used[arrow[i+1]]==true) break;//如果卡片走過，就不能走過去
    used[arrow[i+1]]=true;//走過下一張卡片
    arrowN++;
  }
}

int nextCard(int c){//下一張的位置
  int i=int(c/4), j=c%4;
  return card[i][j];
}

void drawArrow(int c1, int c2){
  int i=int(c1/4), j=int(c1%4);
  int i2=int(c2/4), j2=int(c2%4);
  stroke(255,0,0,128);//半透明紅色線，畫抽排的順序
  strokeWeight(5);
  line( 100+50+j*100, 50+25+i*50, 100+50+j2*100, 50+25+i2*50); 
  stroke(0);//還原成原來的筆觸
  strokeWeight(1);
}

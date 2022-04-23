// 作著：葉正聖 jsyeh@mail.mcu.edu.tw
// 看到網友林仕風的問題，要設計一個撲克牌遊戲，
// 只用16牌，隨機洗牌，放成4x4矩陣，再翻牌
// Step03: 解決之前 i,j 錯亂的問題,並加紅色
// j=0黑桃 j=1紅心 j=2紅磚 j=3梅花 (x座標)
// i=0 A
// i=1 K
// i=2 Q
// i=3 J
// (y座標）
var card = [
  [0, 1, 2, 3],
  [4, 5, 6, 7],
  [8, 9,10,11],
  [12,13,14,15]
];
var w = 100, h = 50;
function setup() {
    initializeFields();
    createCanvas(windowWidth, windowHeight);
    textSize(windowWidth / 30);
    w = windowWidth / 5.1;
    h = windowWidth / 11;
    if(h * 9 > windowHeight) h = windowHeight / 9;
}
function windowResized() {
    resizeCanvas(windowWidth, windowHeight);
    textSize(windowWidth / 30);
    w = windowWidth / 5.1;
    h = windowWidth / 11;
    if(h * 9 > windowHeight) h = windowHeight / 9;
}
function myShuffle() {
    // Step04 洗牌函式
    for (var k = 0; k < 1000; k++) {
        var i = int(random(4)), j = int(random(4));
        var i2 = int(random(4)), j2 = int(random(4));
        var temp = card[i][j];
        card[i][j] = card[i2][j2];
        card[i2][j2] = temp;
    }
    // step05 重設箭頭
    arrowN = -1;
    for (var i = 0; i < 16; i++) usedPos[i] = false;
}
var usedPos=new Array(16);//step05: 對應的格子有無走過
function clearUsedPos() {
    for(var i=0; i<16; i++) usedPos[i]=false;
}
var Face = [ "A", 'K', 'Q', 'J' ];// Face[i]
var Suit = [ '黑桃', '紅心', '紅磚', '梅花'];// Suit[j]
function drawCard(t, i, j) {
    fill(255);
    rect(5+w + w * j, 5+h + h * i, w, h, 10,10,10,10);
  //4x4的卡片區 適時字變紅色
  if(i>=0 && t.charAt(0)=='紅') fill('#ff0000');
  else fill(0);
  text(t, w + w / 2 + w * j, h + h / 2 + h * i);
}//step02: 做出函式 drawCard()來簡化程式碼

function draw() {
    background(255,255,191);
    strokeWeight(1);
    stroke(0);
    textAlign(CENTER,CENTER);
    for(var i=0; i<4; i++){
        drawCard(Face[i], i, -1);
    }
    for(var j=0; j<4; j++){
        drawCard(Suit[j], -1, j);
    }
    for(var i=0; i<4; i++){
        for(var j=0; j<4; j++){
            //step04: 將洗牌的結果 card[i][j] 換算出花色牌面
            var ii = int(card[i][j]/4), jj=card[i][j]%4;
            drawCard( Suit[jj] + Face[ii], i, j);
            if(usedPos[ i * 4 + j ] == false){//step05 模擬時，沒用的牌半透明
                fill(255,128); 
                rect(5+w + j * w, 5+h + i * h, w, h, 10, 10, 10, 10);
            }
        }//step01: 先結合字串，以印出卡片花色＋牌面
    }
  
    noFill();//畫出右下角黑色大框，讓畫面重點更清楚
    strokeWeight(5);
    rect(5+w, 5+h, w * 4, h * 4);
    strokeWeight(1);
  
    if(arrowN!=-1){//step05 draw Arrow
        var line="";
        for(var i=0; i<arrowN; i++){
            var ii=int(arrow[i]/4), jj=arrow[i]%4;
            var c = card[ii][jj];
            line += " "+Suit[c%4]+Face[int(c/4)];
            if(i==6) line += "\n";
            if(i==arrowN-1) break;
            drawArrow( arrow[i], arrow[i+1] );
        }
        fill(0);
        text("你能翻"+arrowN+"張牌: "+line, width / 2, h * 7.2 + w / 6);
    }
    drawCard("先洗牌", 5, 0);
    drawCard("開始玩", 5, 2);
}
function mousePressed() {//step05 模擬遊戲進行
    var i = int((mouseY-5) / h) - 1, j = int((mouseX-5) / w) - 1;
    if(i==5 && j==0) myShuffle();//先洗牌
    if(i==5 && j==2) genArrow();//開始玩
}

var arrow=new Array(17);// arrow to the next card
var arrowN=-1;

function genArrow() {// step05 用箭頭模擬遊戲進行
    for(var i=0; i<16; i++) usedPos[i]=false;
    usedPos[15]=true; // 走過這張卡片
    arrow[0]=15; // 右下角的卡片，存的是位置15
    arrowN=1;
    for(var i=0; i<16-1; i++){
        arrow[i+1] = nextCard(arrow[i]);
        if(usedPos[arrow[i+1]]==true) break; // 如果卡片走過，就不能走過去
        usedPos[arrow[i+1]]=true; // 走過下一張卡片
        arrowN++;
    }
}

function nextCard(c){ // 下一張的位置
    var i=int(c/4), j=c%4;
    return card[i][j];
}

function drawArrow(c1, c2){
    var i=int(c1/4), j=int(c1%4);
    var i2=int(c2/4), j2=int(c2%4);
    stroke(255,0,0,128);
    strokeWeight(5);
    line( w + w / 2 + j * w, h + h / 2 + i * h, w + w / 2 + j2 * w, h + h / 2 + i2 * h); 
    stroke(0);
    strokeWeight(1);
}

function initializeFields() {
    for (var c = 0; c < 4 * 4; c++) {
        card[int(c / 4)][c % 4] = c;
    }

}


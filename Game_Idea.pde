int maxHealth = 60;
float health = 60;
float healthDecrease = 60;
int healthBarWidth = 60;



int gameScreen = 0;
int ballX, ballY;
int ballSize= 20;
int ballColor = color(0);
int racketBounceRate = 20;
float gravity = 1;
float ballSpeedVert = 0;
float airfriction = 0.0001;
float friction = 0.1;
float ballSpeedHorizon = 10;
float ballXspeed;
float ballYspeed;
boolean hitFloor;
int score;

float r;
float g;
float b;

color racketColor = color(random(255));
float racketWidth = 100;
float racketHeight = 10;

void setup() {
  size(500, 500);
  ballX=width/4;
  ballY=height/5;
hitFloor = false;
}


//Different Sections

void draw() {
  // Display the contents of the current screen
  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  } else if (gameScreen == 2) {
    gameOverScreen();
  }

}
//Screen Contents

void initScreen() {
  // codes of initial screen
  background(r,g,b);
  fill(255,3,130);
  textAlign(CENTER);
  text("Click to start", height/2, width/2);
}

void gameScreen() {
  // codes of game screen
  background(255);
  drawBall();
  applyGravity();
  keepInScreen();
  //textSize(score*3);
  //text("Score:" + score, 400,50);
  drawRacket();
  watchRacketBounce();
  applyHorizontalSpeed();
  drawHealthBar();
}

void drawHealthBar(){
 noStroke();
 fill(236,240,241);
 rectMode(CENTER);
 rect(ballX-(healthBarWidth/8), ballY - 30, healthBarWidth, 5 ); 
   if (health > 60) {
    fill(46, 204, 113);
  } else if (health > 30) {
    fill(230, 126, 34);
  } else {
    fill(231, 76, 60);
  }
  rectMode(CORNER);
  rect(ballX-(healthBarWidth/2), ballY - 30, healthBarWidth*(health/maxHealth), 5);
}

void decreaseHealth(){
  health -= healthDecrease;
  if (health <= 0){
    gameOverScreen();
  }
}

void   applyHorizontalSpeed() {
ballX += ballSpeedHorizon;
ballSpeedHorizon -= (ballSpeedHorizon * airfriction);
}


void makeBounceLeft(int surface){
ballX = surface + (ballSize/2);
ballSpeedHorizon*=-1;
ballSpeedHorizon -= (ballSpeedHorizon * friction);
}


void makeBounceRight(int surface){
ballX = surface - (ballSize/2);
ballSpeedHorizon *= -1;
ballSpeedHorizon -= (ballSpeedHorizon * friction);
}

void watchRacketBounce() {
float overhead = mouseY - pmouseY;
if ((ballX+(ballSize/2) > mouseX-(racketWidth/2)) && (ballX-(ballSize/2) < mouseX+(racketWidth/2))) {
if (dist(ballX, ballY, ballX, mouseY)<=(ballSize/2)+abs(overhead)) {
makeBounceBottom(mouseY);
    
if (overhead<0) {
ballY+=overhead;
ballSpeedVert+=overhead;
      }
    }
  }
  if((ballX+(ballSize/2) > mouseX-(racketWidth/2)) && (ballX- (ballSize/2) < mouseX+(racketWidth/2))) {
    if (dist(ballX,ballY, ballX, mouseY) <=(ballSize/2) +abs(overhead)) {
      ballSpeedHorizon = (ballX - mouseX) /5;
    }
  }
}

void drawRacket(){
  fill(racketColor);
  rectMode(CENTER);
  rect(mouseX, mouseY, racketWidth, racketHeight);
}

void applyGravity(){
  
ballSpeedVert += gravity;
ballY += ballSpeedVert;
ballSpeedVert -= (ballSpeedVert * airfriction);  
}

void makeBounceBottom(int surface) {
  ballY= surface-(ballSize/2);
  ballSpeedVert*=-1;
  ballSpeedVert -= (ballSpeedVert * friction);
}

void makeBounceTop(int surface) {
  ballY = surface+(ballSize/2);
  ballSpeedVert*=-1;
  ballSpeedVert -= (ballSpeedVert * friction);
}
void keepInScreen() {
  // ball hits floor
  if (ballY+(ballSize/2) > height) { 
    makeBounceBottom(height);
  }
  // ball hits ceiling
  if (ballY-(ballSize/2) < 0) {
    makeBounceTop(0);
  }
    if (ballX-(ballSize/2) < 0) {
     makeBounceLeft(0); 
    }
    if (ballX+(ballSize/2)> width){
      makeBounceRight(width);
    }
}
void drawBall() {
 fill(ballColor);
  ellipse(ballX,ballY,ballSize, ballSize); 
  
  
}
void gameOverScreen() {
  // codes for game over screen
  if (hitFloor) {
    background (0);
    textAlign(CENTER);
    fill(255);
    textSize(30);
    text("GAME OVER", height/2, width/2 - 20);
  }
}


//Inputs
void keyPressed() {
  if (key == 's') {
    saveFrame("drawing-#####.png");}
  }

public void mousePressed() {
  if (gameScreen==0) {
    startGame();
  }
}
void startGame() {
  gameScreen=1;
}

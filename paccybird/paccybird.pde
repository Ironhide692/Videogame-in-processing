/*sources used: 
https://processing.org/reference
https://www.toptal.com/game/ultimate-guide-to-processing-simple-game 
https://youtu.be/UmHsuoDv-CM
https://www.youtube.com/watch?v=UIlzIwqmOYE 
https://www.youtube.com/watch?v=Xdeih9syh4I
*/

import ddf.minim.*; //creating variables
Minim minim;
AudioPlayer player;
PImage bg;
int bgx, bgy;
PImage background, pacman, ghostObstacle, welcomescreen, suck;
int gameScreen, score, highscore, x, y, vertical, obsx[] = new int[2], obsy[] = new int[2];
PImage[] coin = new PImage[10]; 
void setup(){
   music();
   background = loadImage("bg.png");
   pacman = loadImage("pacman.png");
   ghostObstacle = loadImage("ghosts.png");
   welcomescreen = loadImage("start.png");
   suck = loadImage("suck.png");
   gameScreen = 1; //initializing the game to the welcome screen
   score = 0;
   highscore = 0;
   x = -100;
   vertical = 0; 
   size(1200,800);
   fill(255,255,255);
   textSize(25);
   smooth(); 
   
  coin[0] = loadImage("coin0.png"); //sets up an array of images to represent a gif
  coin[1] = loadImage("coin1.png"); 
  coin[2] = loadImage("coin2.png"); 
  coin[3] = loadImage("coin3.png"); 
  coin[4] = loadImage("coin4.png"); 
  coin[5] = loadImage("coin5.png"); 
  coin[6] = loadImage("coin6.png"); 
  coin[7] = loadImage("coin7.png"); 
  coin[8] = loadImage("coin8.png"); 
  coin[9] = loadImage("coin9.png"); 
 }
void draw() { 
    if(gameScreen == 0) {//set to the game screen
    bg();
    obstacles();
    image(pacman, width/2, y);
    text("Score: "+score, 12, 30);
  }
  /*
  if(gameScreen == 1){
    image(suck, width/2,height/2);
    if(keyCode == 80){
     gameScreen = 3;
   }
  }*/
  else {
    imageMode(CENTER);
    image(welcomescreen, width/2,height/2);
    text("High Score: "+highscore, 20, 40);
  }
 }
  
void mousePressed() {
  vertical = -15; //height of jump
  //if we are on the initial screen or the game click has the function
  //to start the game
  if(gameScreen == 1) { 
    obsx[0] = 600; //creates the space to go through
    obsy[0] = y = height/2;
    obsx[1] = 900;
    obsy[1] = 600;
    x = gameScreen = score = 0; //game starts
  }
}

public void keyPressed(){ //looks for the key pressed and pauses or unpauses the game
// p = 80
// l = 76
 // println(keyCode);
 if(keyCode == 80){ //pauses
   noLoop(); //stop
 }
 else if(keyCode == 76){ //unpases
   loop(); //resume
 }
}
  
  void bg(){
    imageMode(CORNER);
    image(background, x, 0); //movement 
    image(background, x + background.width, 0);
    image(coin[frameCount%10],50,50);
    x -= 6.5; //controls the speed
    vertical += 1; //controls the gravity of pacman
    y += vertical;
    if(x == -1800) x = 0;//this is the width of the background. This helps to be able to scroll infinitely
  }
  void obstacles(){
     for(int i = 0 ; i < 2; i++) {
      imageMode(CENTER);
      image(ghostObstacle, obsx[i], obsy[i] - (ghostObstacle.height/2+100));  //sets the top obstacle
      image(ghostObstacle, obsx[i], obsy[i] + (ghostObstacle.height/2+100));  //sets the top obstacle
      if(obsx[i] < 0) {
        obsy[i] = (int)random(200,height-200);
        obsx[i] = width;
      }
      if(obsx[i] == width/2) highscore = max(++score, highscore); //increses score when pass wall
      if(y>height||y<0||(abs(width/2-obsx[i])<25 && abs(y-obsy[i])>100)) // if pacman goes offscreen or collision 
      gameScreen = 1;
      obsx[i] -= 7.5; //changes the speed at what the obstacles move
    }
  }
  
void music(){ //imports the music file
  minim = new Minim(this);
  player = minim.loadFile("pacTerror.mp3", 450904);
  player.play();
}

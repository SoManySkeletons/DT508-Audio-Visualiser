/*

  DT508 AUDIO VISUALISER PROJECT
  JAMES ETTIE, LIDIEA SOBCENCO AND IAN HUGHES
  
  CONTROLS
  press J, K, and L to change the time of day. Upbeat songs work best during the day and slow ones work better at night.
  
  press Z, X and C to change the red, blue and green saturation of the screen. Press B, N and M to undo the colour addition.

*/


import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;

int  r = 200;
float rad = 70;

int visState;

float carX = 500;
float carY = 500;

float RShift = 0;
float GShift = 0; //THESE 3 values represent the opacity of the colour.
float BShift = 0;

PImage cactus;
PImage cloud;


void setup()
{
  size(1000, 600);
  minim = new Minim(this);
  
  player = minim.loadFile("Troye Sivan - HEAVEN.mp3");
  //player = minim.loadFile("Bag Raiders - Shooting Stars.mp3");
  //player = minim.loadFile("Bastille - Durban Skies.mp3");
  //player = minim.loadFile("Bastille - Get Home.mp3");
  //player = minim.loadFile("Daft Punk - Voyager.mp3");
  //player = minim.loadFile("Foster The People - Pseudologia Fantastica.mp3");
  //player = minim.loadFile("Gorillaz - Stylo.mp3");
  //player = minim.loadFile("Netflix and Chillwave.mp3");
  //player = minim.loadFile("The Chainsmokers X Charlee - Inside Out (Not Your Dope x Spirix Remix).mp3");
  //player = minim.loadFile("The Eden Project - Drowning.mp3");
  //player = minim.loadFile("Don Broco - Nerve.mp3");
  
  
  cactus = loadImage("cactus.png"); //used a simple cactus image from google. Source unknown, I couldnt find an artist to credit.
  cloud = loadImage("cloud.png");
  
  meta = player.getMetaData();
  beat = new BeatDetect();
  player.loop();
  noCursor();
  
  for (int i = 0 ; i < farCactii.length ; i ++) //array for background cacti
  {
    farCactii[i] = new farCacti();
    farCactii[i].cx = random(-width, 0);
    farCactii[i].cy = random(430, 480);
    farCactii[i].speed = 3;
    farCactii[i].size = random(20.0f, 40.0f);
  }
  
  for (int i = 0 ; i < cloud1.length ; i ++) //array for the evening clouds
  {
    cloud1[i] = new cloud();
    cloud1[i].cx = random(-width, 0);
    cloud1[i].cy = random(0, height/2);
    cloud1[i].speed = random(1, 10);
    cloud1[i].size = random(50.0f, 100.0f);
  }  
  
  for (int i = 0 ; i < foreground.length ; i ++) //array for foreground cacti
  {
    foreground[i] = new closeScenery();
    foreground[i].cx = random(-width, 0);
    foreground[i].cy = random(480, height);
    foreground[i].speed = 10;
    foreground[i].size = random(100.0f, 150.0f);
  } 
  
  for (int i = 0 ; i < 200; i ++)
  {
    int starX = (int)random(0, width);
    int starY = (int)random(0, 300);
    int starColour = (int)random(200,255);
    stroke (starColour);
    point (starX,starY);
  }  
}

void draw()
{ 
  //the 3 states of the visualiser, as controlled by the J, K, and L keys.
  
  if(visState == 0)
  {
    drawVis();  
    drawLandscape();
    colourShift();
  }  
  
  if(visState == 1)
  {
    drawVis1();  
    drawLandscapeEvening(); 
    colourShift();
  }
  
  if(visState == 2)
  {
    drawVis2();  
    drawLandscapeNight();  
    colourShift();
  }
  
   
}

void drawVis()
{ 
  fill(200, 200, 255);
  beat.detect(player.mix); 
  noStroke();
  rect(0, 0, width, height); //is the 'sky'
  
 int bsize = player.bufferSize();
 
  fill(255, 255, 102);
  beginShape();  
  
 for (int i = 0; i < bsize; i += 50)
  {
    float x2 = (r + player.left.get(i) * 100) * cos(i * 720 * PI / bsize); 
    float y2 = (r + player.left.get(i) * 100) * sin(i * 720 * PI / bsize); //values that both create the circle and control the intensity of movement
    vertex(x2 + width / 2, y2 + height / 2); //creates the circle 
  }
  endShape();
  
  if (keyPressed)
  {
    if (key == 'j')
    {
      visState = 0;
    }
    if (key == 'k')
    {
      visState = 1;
    }
    if (key == 'l')
    {
      visState = 2;
    }
  }
}

void drawVis1()
{
  
  fill(#F4874B);
  beat.detect(player.mix); 
  noStroke();
  rect(0, 0, width, height); //is the 'sky'
  
  int bsize = player.bufferSize();
 
  fill(#F46A4E);
  beginShape();  
  
 for (int i = 0; i < bsize; i += 50)
  {
    float x2 = (r + player.left.get(i) * 100) * cos(i * 360 * PI / bsize); 
    float y2 = (r + player.left.get(i) * 100) * sin(i * 360 * PI / bsize); //values that both create the circle and control the intensity of movement
    vertex(x2 + width / 2, y2 + height / 2); //creates the circle 
  }
  endShape();
  
  if (keyPressed)
  {
    if (key == 'j')
    {
      visState = 0;
    }
    if (key == 'k')
    {
      visState = 1;
    }
    if (key == 'l')
    {
      visState = 2;
    }
  }
}

void drawVis2()
{ 
  fill(#5C4A72);
  beat.detect(player.mix); 
  noStroke();
  rect(0, 0, width, height); //is the 'sky'
  
 int bsize = player.bufferSize();
 
  fill(200, 200, 255);
  beginShape();  
   
 for (int i = 0; i < bsize; i += 50)
  {
    float x2 = (r + player.left.get(i) * 100) * cos(i * 4 * PI / bsize); 
    float y2 = (r + player.left.get(i) * 100) * sin(i * 4 * PI / bsize); //values that both create the circle and control the intensity of movement
    vertex(x2 + width / 2, y2 + height / 2); //creates the circle 
    ellipse(width/2, height/2, 100, 100);
  }
  endShape();
  
  
  if (keyPressed)
  {
    if (key == 'j')
    {
      visState = 0;
    }
    if (key == 'k')
    {
      visState = 1;
    }
    if (key == 'l')
    {
      visState = 2;
    }
  }
}

void showMeta() 
{
  int time =  meta.length();
  textSize(100);
  textAlign(CENTER);
  text( (int)(time/1000-millis()/1000)/60 + ":"+ (time/1000-millis()/1000)%60, -7, 21);
}

void keyPressed() 
{
  if(key==' ')exit();
  if(key=='s')saveFrame("###.jpeg"); //takes a screenshot
  
}

int cactusCount = 20;
farCacti[] farCactii = new farCacti[cactusCount];

int FGcount = 10;
closeScenery[] foreground = new closeScenery[FGcount];

int cloudCount = 10;
cloud[] cloud1 = new cloud[cloudCount];

void drawLandscape() //renders a mountain range in the background with perlin noise.
{
  fill(255, 0, 255);
  float noiseScale = 0.01;
  for (int x=0; x < width; x++)
  {
    float noiseVal = noise((0+x)*noiseScale, 600*noiseScale);
    stroke(#6E253C);
    line(x, (height/2)+noiseVal*100, x, height);
  }
  
  noStroke(); 
  fill(#EB712F);
  rect(0, height/8*6, width, height/8*2); //draws the orange terrain
  
  fill(#59484F);
  rect(0, height/8*7, width, height/8); //draws the road
  
  for (int i = 0 ; i < farCactii.length ; i ++)
  {
    farCactii[i].update();
    farCactii[i].render();
  }
  
  car();
  
  for (int i = 0 ; i < foreground.length ; i ++)
  {
    foreground[i].update();
    foreground[i].render();
  }
  
}

void drawLandscapeEvening() //renders a mountain range in the background with perlin noise.
{
  fill(255, 0, 255);
  float noiseScale = 0.01;
  for (int x=0; x < width; x++)
  {
    float noiseVal = noise((0+x)*noiseScale, 600*noiseScale);
    stroke(#5C4A72);
    line(x, (height/2)+noiseVal*100, x, height);
  }
  
  noStroke(); 
  fill(#A3586D);
  rect(0, height/8*6, width, height/8*2); //draws the orange terrain
  
  fill(#9C8AA5);
  rect(0, height/8*7, width, height/8); //draws the road
  
  for (int i = 0 ; i < farCactii.length ; i ++)
  {
    farCactii[i].update();
    farCactii[i].render();
  }
  
  car();
  
  for (int i = 0 ; i < foreground.length ; i ++)
  {
    foreground[i].update();
    foreground[i].render();
  }
  
  for (int i = 0 ; i < cloud1.length ; i ++)
  {
    cloud1[i].update();
    cloud1[i].render();
  }
  
}

void drawLandscapeNight() //renders a mountain range in the background with perlin noise.
{
  fill(255, 0, 255);
  float noiseScale = 0.01;
  for (int x=0; x < width; x++)
  {
    float noiseVal = noise((0+x)*noiseScale, 600*noiseScale);
    stroke(#421C52);
    line(x, (height/2)+noiseVal*100, x, height);
  }
  
  
  
  noStroke(); 
  fill(#732C7B);
  rect(0, height/8*6, width, height/8*2); //draws the orange terrain
  
  fill(#9C8AA5);
  rect(0, height/8*7, width, height/8); //draws the road
  
  for (int i = 0 ; i < farCactii.length ; i ++)
  {
    farCactii[i].update();
    farCactii[i].render();
  }
  
  car();
  
  for (int i = 0 ; i < foreground.length ; i ++)
  {
    foreground[i].update();
    foreground[i].render();
  }
  
}

/*the colours can be controlled using the following keys
z - increases red tint
x - increases blue tint
c - increases green tint
b - decreases red tint
n - decreses blue tint
m - decreases green tint
*/

void colourShift() //this is my favourite part of the code, as it changes the colours and softly blurs the sketch to add an almost foggy effect.
{
  fill(255, 0, 0, RShift); //the 3 large blocks that are the colour. 
  rect(0,0, width, height);
  
  fill(0, 255, 0, GShift);
  rect(0,0, width, height);
  
  fill(0, 0, 255, BShift);
  rect(0,0, width, height);

  if (keyPressed)
    {
      if (key == 'z')
      {
        RShift++;
        if (RShift >= 80)
        {
          RShift = 80;
        }
      }   
      
      if (key == 'x')
      {
        BShift++;
        if (BShift >= 80)
        {
          BShift = 80;
        }
      }
      
      if (key == 'c')
      {
        GShift++;
        if (GShift >= 80)
        {
          GShift = 80;
        }
      }
      
      if (key == 'b')
      {
        RShift--;
        if (RShift <= 0)
        {
          RShift = 0;
        }
      }   
      
      if (key == 'n')
      {
        BShift--;
        if (BShift <= 0)
        {
          BShift = 0;
        }
      }
      
      if (key == 'm')
      {
        GShift--;
        if (GShift <= 0)
        {
          GShift = 0;
        }
      }
   }
}

void car()
{
  noStroke();


  //Interior
  noStroke();
  stroke(0);
  fill(0);
  line(carX, carY + 5, carX - 5, carY - 18);
  fill(10);
  ellipse(carX + 75, carY - 30, 20, 30);
  ellipse(carX + 80, carY - 10, 30, 20);
  ellipse(carX + 10, carY - 10, 10, 10);
  quad(carX + 90, carY + 5, carX + 110, carY + 5, carX + 120, carY - 35, carX + 100, carY - 33);

  // Lights
  noStroke();
  stroke(255);
  fill(2555, 255, 100);
  ellipse(carX - 180, carY + 18, 10, 18);
  fill(255,50,50);
  rect(carX + 320, carY + 14, 10, 15);
  
  // Roof
  stroke(0);
  noStroke();
  fill(#C25E4F);
  quad(carX + 180, carY, carX + 250, carY, carX + 160, carY - 50, carX + 120, carY - 55);
  quad(carX + 130, carY - 55, carX + 130, carY - 50, carX + 20, carY - 52, carX + 20, carY - 55);
  stroke(10);
  line(carX + 120, carY, carX + 123, carY - 48);
  line(carX - 30, carY, carX + 20, carY - 53);
  
  // Body
  noStroke();
  // Front
  noStroke();
  rect(carX - 100, carY - 10, 25, 20);
  fill(#C25E4F);
  quad(carX, carY - 10, carX - 180, carY + 2, carX - 180, carY + 50, carX, carY +62);
  quad(carX - 160, carY + 50, carX - 170, carY + 50, carX - 180, carY + 60, carX - 180, carY + 60);
  rect(carX - 190, carY + 30, 40, 8);
  
  
  // Rear
  noStroke();
  fill(#C25E4F);
  quad(carX + 160, carY - 10, carX + 330, carY + 1, carX + 320, carY + 50, carX +160, carY + 62);
  line(carX + 170, carY + 40, carX + 175, carY + 30);
  line(carX + 180, carY + 40, carX + 185, carY + 30);
  rect(carX + 300, carY + 30, 30, 8);
  
  
  // Middle
  noStroke();
  stroke(0);
  fill(#75191C);
  noStroke();
  rect(carX - 30,carY - 10, 190, 70);
  stroke(130);
  line(carX + 120, carY + 1, carX + 140, carY);

  
 
  // Front Wheel
  noStroke();
  stroke(0);
  fill(50);
  ellipse(carX - 100, carY + 50, 80, 80);
  fill(150);
  ellipse(carX - 100, carY + 50, 60, 60);
  noFill();
  arc(carX - 100, carY + 50, 50, 50, 0, PI / 3.0);
  arc(carX - 100, carY + 50, 40, 40, 0, PI / 3.0);
  arc(carX - 100, carY + 50, 30, 30, 0, PI / 3.0);
  arc(carX - 100, carY + 50, 50, 50, PI, PI+QUARTER_PI);
  arc(carX - 100, carY + 50, 40, 40, PI, PI+QUARTER_PI);
  arc(carX - 100, carY + 50, 30, 30, PI, PI+QUARTER_PI);
  
  // Rear Wheel
  noStroke();
  stroke(0);
  fill(50);
  ellipse(carX + 230, carY + 50, 80, 80);
  fill(150);
  ellipse(carX + 230, carY + 50, 60, 60);
  noFill();
  arc(carX + 230, carY + 50, 50, 50, 0, PI / 3.0);
  arc(carX + 230, carY + 50, 40, 40, 0, PI / 3.0);
  arc(carX + 230, carY + 50, 30, 30, 0, PI / 3.0);
  arc(carX + 230, carY + 50, 50, 50, PI, PI+QUARTER_PI);
  arc(carX + 230, carY + 50, 40, 40, PI, PI+QUARTER_PI);
  arc(carX + 230, carY + 50, 30, 30, PI, PI+QUARTER_PI);
  
  carY -= random(1, 2);
  if (carY <= 480)
  {
    carY += random(1, 2);
  }
  else carY -= random(1, 2);
  
}

  
  
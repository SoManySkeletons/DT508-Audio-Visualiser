class farCacti //background scenery, behind the car
{
  float cx;
  float cy;
  float size;
  float speed;
  
  void update()
  {
    cx += speed;
    
    if (cx > width)
    {
      cx = random(-width, 0); //spawns the cacti off screen to scroll in
      cy = random(430, 480); //give some height variation
      size = random(20.0f, 40.0f); 
      speed = 3;
    }
  }
  
  void render()
  {
    image(cactus, cx, cy, size, size);
  }
}

class closeScenery //the foreground scenery, in front of the car
{
  float cx;
  float cy;
  float size;
  float speed;
  
  void update()
  {
    cx += speed;
    
    if (cx > width)
    {
      cx = random(-width, 0); //spawns cacti off screen
      cy = random(540, height); // gives height variation
      size = random(100.0f,150.0f); //gives size variation
      speed = 10;
    }
  }
  
  void render()
  {
    image(cactus, cx, cy, size, size);
  }
}

class cloud
{
  float cx;
  float cy;
  float size;
  float speed;
  
  void update()
  {
    cx += speed;
    
    if (cx > width)
    {
      cx = random(-width, 0); //spawns clouds off screen
      cy = random(0, height/2); // gives height variation
      size = random(50.0f,100.0f); //gives size variation
      speed = random(0, 10);
    }
  }
  
  void render()
  {
    image(cloud, cx, cy, size, size);
  }
}
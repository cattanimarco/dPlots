Clock clock;

float val = 0;


void setup() {   
  frameRate(30);
  size(500, 500);
  clock = new Clock("demo",500.0,60);
  clock.x = 250.0;
  clock.y = 250.0;
}

void draw() {
  background(153);

  if(frameCount%30 == 0){
    clock.setValue(val);
    clock.update();
    val = val + random(-10,10);
  }
  clock.draw();
  
}
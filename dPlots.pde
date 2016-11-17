Clock clock;
Radar radar;
float val = 0;


void setup() {   
  frameRate(30);
  size(1000, 500);
  clock = new Clock("demo",500.0,60);
  radar = new Radar(5,500.0);

  clock.position.x = 0;
  clock.position.y = 0;

  radar.position.x = 500;
  radar.position.y = 0;
  
}

void draw() {
  background(153);

  if(frameCount%30 == 0){
    
    clock.setValue(val);
    clock.update();
    val = val + random(-10,10);
    
    for(int i=0;i<5;i++){
      val = val + random(-10,10);
      radar.addData(val,i);
    }
    
    
  }
  
  clock.draw();
  radar.draw();
}
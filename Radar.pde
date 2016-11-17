class Radar extends Widget{

  
  Radar(int _dim, float _size){
  
  super(_dim); 
    
  size.x = _size;
  size.y = _size;
  ratio.x = 1;
  ratio.y = 1;
  
  }
  
  
void draw() {
    
  float bigRadius = size.x/2;
  float smallRadius = bigRadius/5;
  float increments = (bigRadius-smallRadius)/25;

  float[] normVals = new float[dimensions];
  float[] vals = new float[dimensions];
  float[] degrees = new float[dimensions];

  // if node is selected
  selected = (sq((position.x+size.x/2) - mouseX) + sq((position.y+size.y/2) - mouseY) < sq(smallRadius/2));
  
    
  for(int d=0;d<dimensions;d++){
       if(data[d].size()>0){    
      normVals[d] = (data[d].get(data[d].size()-1)-data[d].min())/(data[d].max()-data[d].min());      
       }
       else{
       normVals[d]=0;
       }
      vals[d] = (bigRadius-smallRadius)*normVals[d];
       degrees[d] = (float(d)/float(dimensions))*(PI*2);
  }
  
  for(int d=0;d<dimensions;d++){
    float start_x,start_y,stop_x,stop_y;
    
   
  
    strokeWeight(1);
 
    
    stroke(colors.base, colors.opacity); // regular
    start_x = cos(degrees[d])*(smallRadius);
    start_y = sin(degrees[d])*(smallRadius);      
    stop_x = cos(degrees[(d+1)%dimensions])*((smallRadius));
    stop_y = sin(degrees[(d+1)%dimensions])*((smallRadius));
    line(position.x+size.x/2+start_x, position.y+size.y/2+start_y, position.x+size.x/2+stop_x, position.y+size.y/2+stop_y);
 
    start_x = cos(degrees[d])*(bigRadius);
    start_y = sin(degrees[d])*(bigRadius);      
    stop_x = cos(degrees[(d+1)%dimensions])*((bigRadius));
    stop_y = sin(degrees[(d+1)%dimensions])*((bigRadius));
    line(position.x+size.x/2+start_x, position.y+size.y/2+start_y, position.x+size.x/2+stop_x, position.y+size.y/2+stop_y);
 

   start_x = cos(degrees[d])*(smallRadius+vals[d]);
   start_y = sin(degrees[d])*(smallRadius+vals[d]);      
   stop_x = cos(degrees[(d+1)%dimensions])*((smallRadius)+vals[(d+1)%dimensions]);
   stop_y = sin(degrees[(d+1)%dimensions])*((smallRadius)+vals[(d+1)%dimensions]);
       stroke(colors.plotline, colors.opacity); // regular
    line(position.x+size.x/2+start_x, position.y+size.y/2+start_y, position.x+size.x/2+stop_x, position.y+size.y/2+stop_y);
    
  }
  
  
  }
  
}
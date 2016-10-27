
class Clock extends Widget
{
  
float currentValue = 0; //default starting value
int ttl = 0;
float shrinkRatio = 0.3;
int max_ttl = 60; // maximum number of updates before considering the widget obsolete
float growing = 0;
float size;    
  
int clockOffset = 0;

//  int ds = 2;
//  float scaleValues = 5.0;
//  String label; 
//  boolean selected;
//  boolean locked = false;
//  boolean dragging = false;
//  int historyIndex = 0;
  

/* -------------- FUNCTIONS --------------------- */

Clock(String _label, float _size, int _bufferSize) {
  super(1); 
  labels.append(_label);
  title = _label;
  wWidth = _size;
  wHeight = _size;
  size = _size;
  ttl = max_ttl;
  dataBufferSize = _bufferSize;
}

void ttlReset(){
  ttl = max_ttl;
}

void setValue(float _val){
  currentValue = _val;
  ttlReset();
}

void update(){
    addData(currentValue, 0);
    if (ttl>0) ttl = ttl-1;
    clockOffset = (clockOffset+1)%dataBufferSize;
}
  
  
void draw() {
    
  float bigRadius = size/2;
  float smallRadius = shrinkRatio * bigRadius;
  
  // if node is selected
  selected = (sq(x - mouseX) + sq(y - mouseY) < sq(smallRadius/2));
  // show values on a larger circle
  if (selected) {  
    fill(#E56498, opacity);  // pink if mouseover
    if (growing < (bigRadius-smallRadius)) growing = growing+1.0;
  } else {
    if (ttl>0)
      fill(wColor, opacity); // regular
    else 
      fill(#FF0000, opacity); // ttl exipred, data is too old
    if (growing > 0) {
      if (growing > 5.0) 
        growing = growing-5.0;
      else
        growing = 0.0;
    }
  }
  
  // Draw inner circle 
  ellipse(x, y, smallRadius, smallRadius);    
  noStroke();          
  
  // Draw title
  textSize(12);
  fill(0,0,0,150);
  textAlign(CENTER,CENTER);
  text(title,x,y);   
  
  // draw history (colored dots around the node)
  stroke(0,0,0,25);
  noFill();
  if(selected){
    // TODO draw an optional gridline
      //float firstCircle = r+2*((maxValue/3)*scaleValues);
      //float secondCircle = r+2*(((maxValue*2)/3)*scaleValues);
      //float thirdCircle = r+2*(maxValue*scaleValues);
      //ellipse(x, y, thirdCircle, thirdCircle);
      //ellipse(x, y, secondCircle, secondCircle);
      //ellipse(x, y, firstCircle, firstCircle);
  } 
  for(int i=0;i<data[0].size();i++){
    // decise at which angle to draw the datapoint
    float degree = (float(i+clockOffset)/float(dataBufferSize))*(PI*2);
    // normalize value base on the whole dataset
    float normVal = (data[0].get(i)-data[0].min())/(data[0].max()-data[0].min());
    // scale the values and apply growing animation
    float val = min(normVal*(bigRadius-smallRadius),growing);
    // decide gradient color
    int indexColor = int(normVal*63);
    // compute line positions
    float start_x = cos(degree)*(smallRadius/2);
    float start_y = sin(degree)*(smallRadius/2);      
    float val_x = cos(degree)*((smallRadius/2)+val);
    float val_y = sin(degree)*((smallRadius/2)+val);
    strokeWeight(1);
    
    // draw circular density
    fill(ColorTools.heatmap[indexColor][0]*255,ColorTools.heatmap[indexColor][1]*255,ColorTools.heatmap[indexColor][2]*255, 255);    
    if (i == data[0].size()-1){
        stroke(255,0,0, 255);
        line(x+start_x, y+start_y, x+val_x, y+val_y);
        noStroke();
        ellipse(x+val_x,y+val_y, 8, 8);
      } else {
        stroke(0,0,0, 25);
        line(x+start_x, y+start_y, x+val_x, y+val_y);
        noStroke();
        ellipse(x+val_x, y+val_y, 3, 3);
      }
    }
  }
}
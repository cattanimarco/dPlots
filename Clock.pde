
class Clock extends Widget
{
  
float currentValue = 0; //default starting value
int ttl = 0;
int max_ttl = 60; // maximum number of updates before considering the widget obsolete
float growing = 0;
  
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
    
  size.x = _size;
  size.y = _size;
  ratio.x = 1;
  ratio.y = 1;
  
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
    
  float bigRadius = size.x/2;
  float smallRadius = bigRadius/3;
  float increments = (bigRadius-smallRadius)/25;
  
  // if node is selected
  selected = (sq((position.x+size.x/2) - mouseX) + sq((position.y+size.y/2) - mouseY) < sq(smallRadius/2));
  // show values on a larger circle
  if (selected) {  
    fill(colors.selected, colors.opacity);  // pink if mouseover
    if (growing < (bigRadius-smallRadius)) growing = growing+increments;
  } else {
    if (ttl>0)
      fill(colors.base, colors.opacity); // regular
    else 
      fill(colors.invalid, colors.opacity); // ttl exipred, data is too old
    if (growing > 0) {
      if (growing > increments) 
        growing = growing-increments;
      else
        growing = 0.0;
    }
  }
  
  // Draw inner circle 
  ellipse(position.x+size.x/2, position.y+size.y/2, smallRadius, smallRadius);    
  noStroke();          
  
  // Draw title
  textSize(12);
  fill(0,0,0,150);
  textAlign(CENTER,CENTER);
  text(title,position.x+size.x/2,position.y+size.y/2);   
  
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
        line(position.x+size.x/2+start_x, position.y+size.y/2+start_y, position.x+size.x/2+val_x, position.y+size.y/2+val_y);
        noStroke();
        ellipse(position.x+size.x/2+val_x,position.y+size.y/2+val_y, size.x/40, size.y/40);
      } else {
        stroke(0,0,0, 25);
        line(position.x+size.x/2+start_x, position.y+size.y/2+start_y, position.x+size.x/2+val_x, position.y+size.y/2+val_y);
        noStroke();
        ellipse(position.x+size.x/2+val_x, position.y+size.y/2+val_y, size.x/80, size.y/80);
      }
    }
  }
}
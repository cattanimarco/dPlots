
class Widget
{
// widget data
int dimensions;
StringList labels;
FloatList[] data;
int dataBufferSize = -1;

// widget position and dimension
float x = 0;
float y = 0;
float wWidth = 100;
float wHeight = 100;
// widget apparence
color wColor = #669933;
float opacity = 255;
//PFont arial = loadFont("Arial-Black-20.vlw");
// widget state
String title; 
boolean selected;
  

/* -------------- FUNCTIONS --------------------- */

Widget(int dim) {
  dimensions = dim;
  data = new FloatList[dimensions];
  labels = new StringList();
  
  for(int i=0;i<dimensions;i++){
    //labels.append(str(i));
    data[i] = new FloatList();
  }
  
}

boolean addData(float val, int dim){
  if (dim < dimensions){
    // if the buffer size is fixed, we remove elements until the size is max-1
    if (dataBufferSize > 0){
        while (data[dim].size() >= dataBufferSize) data[dim].remove(0);
    }
    data[dim].append(val);
    return true;
  } else {
    return false;
  }
}

void setMin(){

}

void setMax(){

}

float getMin(){
  float min = data[0].min();
  for(int i=1;i<dimensions;i++){
    float m = data[i].min();
    if (m < min) min = m;
  }
  return min;
}

float getMax(){
  float max = data[0].max();
  for(int i=1;i<dimensions;i++){
    float m = data[i].max();
    if (m > max) max = m;
  }
  return max;
}



}
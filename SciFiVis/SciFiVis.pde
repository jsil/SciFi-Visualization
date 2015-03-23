/* Digital Humanities Project
   Visualization of Imagined Science Fiction Locations

   Code by Kali Rupert & Jordan Silver
*/

/* Pre-loading images for Processing.js
   @pjs preload="img/world32k.jpg";
*/



// textureSphere code from: https://processing.org/examples/texturesphere.html
// variables for texturing sphere:
int ptsW, ptsH;

int numPointsW;
int numPointsH_2pi; 
int numPointsH;

float[] coorX;
float[] coorY;
float[] coorZ;
float[] multXZ;



PImage img;

int screenWidth;
int screenHeight;

boolean web;

float zRot;
float yRot;

float camX;

void setWeb() {
   web = true; 
}

void loadWeb(boolean isWeb) {
  if(isWeb) {
      img=loadImage("img/world32k.jpg");
      screenWidth = 800;
      screenHeight = 600;
  }
  else {
      img=loadImage("world32k.jpg");
      screenWidth = displayWidth;
      screenHeight = displayHeight;
  }
}


void setup() {
  loadWeb(false);
  
  size(screenWidth,screenHeight,P3D);
  
  ptsW=30;
  ptsH=30;
  // Parameters below are the number of vertices around the width and height
  initializeSphere(ptsW, ptsH);
  
  zRot = 0;
  yRot = 0;
  
  camX = width/2;
}


void draw() {
  
  background(0);
//  camera(width/2+map(mouseX, 0, width, -2*width, 2*width), 
//         height/2+map(mouseY, 0, height, -height, height),
//         height/2/tan(PI*30.0 / 180.0), 
//         width, height/2.0, 0, 
//         0, 1, 0);

  camera(camX,height/2,0,
      camX,height/2,-2000,
      0.0,1.0,0.0);
  
  pushMatrix();
  
  translate(width/2, height/2, -2000);
  
  rotateX(radians(-20));
  rotateY(radians(yRot));
  
  noStroke();
  textureSphere(200, 200, 200, img);
  
  popMatrix();
  
  yRot = yRot + 0.5;
}

// Use arrow keys to change detail settings
void keyPressed() {
//  if (keyCode == ENTER) saveFrame();
//  if (keyCode == UP) ptsH++;
//  if (keyCode == DOWN) ptsH--;
//  if (keyCode == LEFT) ptsW--;
//  if (keyCode == RIGHT) ptsW++;
//  if (ptsW == 0) ptsW = 1;
//  if (ptsH == 0) ptsH = 2;
//  // Parameters below are the number of vertices around the width and height
//  initializeSphere(ptsW, ptsH);
if(keyCode == RIGHT) {
   camX = camX + 15; 
}
else if(keyCode == LEFT) {
   camX = camX - 15; 
}
}


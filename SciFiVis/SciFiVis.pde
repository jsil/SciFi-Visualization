/* Digital Humanities Project
 Visualization of Imagined Science Fiction Locations
 
 Code by Kali Rupert & Jordan Silver
 */

/* Pre-loading images for Processing.js
 @pjs preload="img/world32k.jpg,img/starscape.jpg";
 */

// textureSphere code from: https://processing.org/examples/texturesphere.html
// variables for texturing sphere:


PImage bg;
PImage img;

int screenWidth;
int screenHeight;

boolean web;

float zRot;
float yRot;

float camX;
float camY;

float dragX;
float dragY;

ArrayList<Node> testNodes;

UI ui;

void setWeb() {
  web = true;
}

void loadWeb(boolean isWeb) {
  if (isWeb) {
    img=loadImage("img/world32k.jpg");
    bg=loadImage("img/starscape.jpg");
    println("image loaded");
    screenWidth = 800;
    screenHeight = 600;
    //bg.resize(800,600);
  } else {
    img=loadImage("world32k.jpg");
    bg=loadImage("starscape.jpg");
    screenWidth = displayWidth;
    screenHeight = displayHeight;
    bg.resize(screenWidth, screenHeight);
  }
  println(bg.width);
}


void setup() {
  loadWeb(false);

  println("bg width: " + bg.width + "; canvas width: " + screenWidth);
  size(screenWidth, screenHeight, P3D);

  //initialize variables
  // Parameters below are the number of vertices around the width and height
  ptsW=30;
  ptsH=30;
  initializeSphere(ptsW, ptsH);

  zRot = 0;
  yRot = 0;

  camX = width/2;
  camY = height/2;

  ui = new UI();

  parseTable();
}


void draw() {
  bg.resize(screenWidth, screenHeight);
  background(bg);

  //  camera(width/2+map(mouseX, 0, width, -2*width, 2*width), 
  //         height/2+map(mouseY, 0, height, -height, height),
  //         height/2/tan(PI*30.0 / 180.0), 
  //         width, height/2.0, 0, 
  //         0, 1, 0);
  
  beginCamera();

  camera(camX, camY, 0, 
  camX, height/2, -2000, 
  0.0, 1.0, 0.0);


  //translate to center
  pushMatrix();//0

  translate(width/2, height/2, -2000);

  pushMatrix();//1

  rotateX(radians(-20));
  
  //draw center
  pushMatrix();//2a
  rotateY(radians(yRot));
  noStroke();
  textureSphere(200, 200, 200, img);
  popMatrix();//2a

  //draw ellipse
  pushMatrix();//2b
  rotateX(radians(90));
  noFill();
  stroke(255);
  ellipseMode(CENTER);
  ellipse(0, 0, 1500, 1500);
  popMatrix();//2b


  //draw nodes
  for (int i=0; i<testNodes.size (); i++) {
    pushMatrix();//2c
    testNodes.get(i).draw(); 
    popMatrix();//2c
  }

  
  endCamera();
  
  popMatrix();//1

  popMatrix();//0
  
  camera();//reset camera so UI can be drawn accurately
  
  pushMatrix();
  ui.draw();
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
  if (keyCode == RIGHT) {
    camX = camX + 15;
  } else if (keyCode == LEFT) {
    camX = camX - 15;
  }
}

void mousePressed() {
  dragY = mouseY;
  dragX = mouseY;
}

void mouseDragged() {
  camY = (mouseY - dragY) * 5;
  camX = -1-((mouseX - dragX) * 5);
}

void parseTable() {
  Table table = loadTable("testData.csv", "header");
  testNodes = new ArrayList<Node>();

  for (TableRow row : table.rows ()) {
    String novel = row.getString(0);
    String author  = row.getString(1);
    int published = row.getInt(2);
    String dateOfAction = row.getString(3);
    String locationOfAction = row.getString(4);

    testNodes.add(new Node(novel, author, published, dateOfAction, locationOfAction));
    //println("added " + novel);
  }
}


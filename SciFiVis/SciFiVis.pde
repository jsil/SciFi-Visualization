/* Digital Humanities Project
 Visualization of Imagined Science Fiction Locations
 
 Code by Kali Rupert & Jordan Silver
 */

/* @pjs font="Facet.ttf"; */

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

ArrayList<Node> nodes;

PFont defaultFont;

UI ui;

boolean DEBUG = false;

void setWeb() {
  web = false;
}

void loadWeb(boolean isWeb) {
  if (isWeb) {
    img=loadImage("img/world32k.jpg");
    bg=loadImage("img/starscape.jpg");
    screenWidth = 1280  ;
    screenHeight = 678;
    //bg.resize(800,600);
    nodes = new ArrayList<Node>();
  } else {
    img=loadImage("world32k.jpg");
    bg=loadImage("starscape.jpg");
    screenWidth = displayWidth;
    screenHeight = displayHeight;
    bg.resize(screenWidth, screenHeight);
    parseTable();
  }
  defaultFont = createFont("Facet", 18);
}

//void resize(int w, int h) {
//  println("resized");
//  size(w, h, P3D);
//  //   draw();
//}


void setup() {
  loadWeb(true);

  //  println("bg width: " + bg.width + "; canvas width: " + screenWidth);
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

  //println(searchNodes("du"));
}


void draw() {
  bg.resize(screenWidth, screenHeight);
  //  background(bg);
  background(0);

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
  for (int i=0; i<nodes.size (); i++) {
    pushMatrix();//2c
    nodes.get(i).draw(); 
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
    camX = camX + 35;
  } else if (keyCode == LEFT) {
    camX = camX - 35;
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

void addNode(String novel, String author, int published, String dateOfAction, String locationOfAction) {
  nodes.add(new Node(novel, author, published, dateOfAction, locationOfAction));
  if (DEBUG)
    println("N: " + novel + " A: " + author + " P: " + published);
}

void parseTable() {
  Table table = loadTable("testData.csv", "header");
  nodes = new ArrayList<Node>();

  for (TableRow row : table.rows ()) {
    String novel = row.getString(0);
    String author  = row.getString(1);
    int published = row.getInt(2);
    String dateOfAction = row.getString(3);
    String locationOfAction = row.getString(4);

    nodes.add(new Node(novel, author, published, dateOfAction, locationOfAction));
    //println("added " + novel);
  }
}

String[] searchNodes(String search) {
  ArrayList<String> returnedStrings = new ArrayList<String>();
  for (int i=0; i<nodes.size (); i++) {
    if (nodes.get(i).contains(search)) {
      returnedStrings.add(nodes.get(i).getNovel());
    }
  }
  String[] convertedStrings = new String[returnedStrings.size()];
  for (int i=0; i<returnedStrings.size (); i++) {
    convertedStrings[i] = returnedStrings.get(i);
  }

  return convertedStrings;
}


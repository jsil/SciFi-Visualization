/* Digital Humanities Project
 Visualization of Imagined Science Fiction Locations
 
 Code by Kali Rupert & Jordan Silver
 */

/* @pjs font="Facet.ttf"; */

/* Pre-loading images for Processing.js
 @pjs preload="img/world32k.jpg,img/starscape.jpg";
 */


//TODO:
/*
  analytics percentage
 figure out toggle-able options
 -fiction or non-fiction
 novels with multiple locations (The Forever War)
 
 
 */


// textureSphere code from: https://processing.org/examples/texturesphere.html
// variables for texturing sphere:

int earthCount;
int novelCount;

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

float panX;
float panY;
float zoom;

boolean DEBUG = true;

void setWeb() {
  web = false;
}

void loadWeb(boolean isWeb) {
  if (isWeb) {
    img=loadImage("img/world32k.jpg");
    bg=loadImage("img/starscape.jpg");
    screenWidth = 1280;
    screenHeight = 678;
    //bg.resize(800,600);
    nodes = new ArrayList<Node>();
  } else {
    img=loadImage("world32k.jpg");
    bg=loadImage("starscape.jpg");
    screenWidth = displayWidth;
    screenHeight = displayHeight;
    bg.resize(screenWidth, screenHeight);
    parseTable("pre1969.csv");
    parseTable("post1969.csv");
    parseTable("post1990.csv");
  }
  defaultFont = createFont("Facet", 18);
}

//void resize(int w, int h) {
//  println("resized");
//  size(w, h, P3D);
//  //   draw();
//}


void setup() {

  nodes = new ArrayList<Node>();

  panX = 0;
  panY = 0;
  zoom = 0;

  loadWeb(true);

  //  println("bg width: " + bg.width + "; canvas width: " + screenWidth);
  size(screenWidth, screenHeight, P3D);

  novelCount = 0;

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


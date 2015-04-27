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


PImage bg;
PImage earthImg;
PImage moonImg;
PImage marsImg;


int screenWidth;
int screenHeight;

boolean web;

float zRot;
float yRot;

float camX;
float camY;

float dragX;
float dragY;

PFont defaultFont;

UI ui;
NodeHandler nodeHandler;

float panX;
float panY;
float zoom;

boolean DEBUG = true;

Earth earth;

Moon moon;

Mars mars;


void setup() {

  ui = new UI();
  nodeHandler = new NodeHandler();

  loadWeb(false);

  size(screenWidth, screenHeight, P3D);
  
  loadPlanets();


  //initialize variables
  // Parameters below are the number of vertices around the width and height
  ptsW=30;
  ptsH=30;
  initializeSphere(ptsW, ptsH);

  panX = 0;
  panY = 0;
  zoom = 0;

  zRot = 0;
  yRot = 0;

  camX = width/2;
  camY = height/2;
}

void loadPlanets() {
    earth = new Earth(earthImg);
    moon = new Moon(moonImg);
    mars = new Mars(marsImg);
    
    earth.say();
    moon.say();
    mars.say();
}


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
 space nodes more appropriately
 novels with multiple locations (The Forever War)
 */


//BUGS:
/*
 web-
   novel count on web is 3 higher than actual
   earth texture wrap is buggy
 */


// textureSphere code from: https://processing.org/examples/texturesphere.html
// variables for texturing sphere:


UI ui;
NodeHandler nodeHandler;

Earth earth;
Moon moon;
Mars mars;

PImage bg;
PImage earthImg;
PImage moonImg;
PImage marsImg;

int screenWidth;
int screenHeight;

boolean DEBUG = false;
boolean web = true;


void setup() {

  ui = new UI();
  nodeHandler = new NodeHandler();

  loadWeb(web);

  size(screenWidth, screenHeight, P3D);

  loadPlanets();
}

void loadPlanets() {

  prepSphere();
  earth = new Earth(earthImg);
  moon = new Moon(moonImg);
  mars = new Mars(marsImg);

  if (DEBUG) {
    earth.say();
    moon.say();
    mars.say();
  }
}


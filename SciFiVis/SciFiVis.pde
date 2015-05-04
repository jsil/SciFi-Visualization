/* Digital Humanities Project
 Visualization of Imagined Science Fiction Locations
 
 Code by Kali Rupert & Jordan Silver
 */

/* @pjs font="Facet.ttf"; */

/* Pre-loading images for Processing.js
 @pjs preload="img/world32k.jpg,img/moon.jpg,img/marsmap2k.jpg,img/starscape.jpg,img/mwg.png";
 */


/*TODO:
 add description
 smooth keyboard controls
 web-
 implement zoom
 implement background image
 make nodeHandler class visible in javascript
 */

/*BUGS:
 web-
 */

UI ui;
NodeHandler nodeHandler;
Earth earth;
Moon moon;
Mars mars;

PImage bg;
PImage earthImg;
PImage moonImg;
PImage marsImg;
PImage mwgImg;

int screenWidth;
int screenHeight;

boolean DEBUG = false;
boolean web = false;

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


import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SciFiVis extends PApplet {

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

public void setup() {
  ui = new UI();
  nodeHandler = new NodeHandler();

  loadWeb(web);
  size(screenWidth, screenHeight, P3D);
  loadPlanets();
}

public void loadPlanets() {
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

float dragX;
float dragY;

float panX = 0;
float panY = 0;
float zoom = -800;

public void keyPressed() {
  if (ui.getShowInfo()) {
    ui.toggleInfo();
  } else {
    if (keyCode == LEFT) {
      panX = panX + 35;
    } else if (keyCode == RIGHT) {
      panX = panX - 35;
    }
    if (keyCode == UP) {
      panY = panY + 35;
    } else if (keyCode == DOWN) {
      panY = panY - 35;
    }
    if (key == '1') {
      //    nodeHandler.toggleFilter(0);
      nodeHandler.toggleDateofActionUser(0);
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    }
    if (key == '2') {
      //    nodeHandler.toggleFilter(1);
      nodeHandler.toggleDateofActionUser(1);
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    }
    if (key == '3') {
      //    nodeHandler.toggleFilter(2);
      nodeHandler.toggleDateofActionUser(2);
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    }
    if (key == '4') {
      nodeHandler.togglePublished(0); 
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    }
    if (key == '5') {
      nodeHandler.togglePublished(1); 
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    }
    if (key == '6') {
      nodeHandler.togglePublished(2);
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    }
    if (key == 's') {
      ui.toggleStats();
    }
    if (key == 'c') {
      ui.toggleControls();
    }
    if (key == 'i') {
      ui.toggleInfo();
    }
    if (key == 'f') {
      ui.toggleFilters();
    }
    if (key == 'q') {
      nodeHandler.toggleDateofActionWork(0);
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    }
    if (key == 'w') {
      nodeHandler.toggleDateofActionWork(1);
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    }
    if (key == 'e') {
      nodeHandler.toggleDateofActionWork(2);
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    }
    if (key == 'r') {
      nodeHandler.toggleDateofActionWork(3);
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    }
    if (key == 't') {
      nodeHandler.toggleDateofActionWork(4);
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    }
    if (key == ' ') {
      ui.toggleSolar();
      if (ui.isSolar()) {
        zoom = -800;
      } else {
        zoom = -100;
      }
    }
  }
}

public void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom += 3.5f*e;
  if (zoom > 1200) {
    if (!ui.isSolar()) {
      zoom = -800;
      ui.toggleSolar();
    }
  } else if (zoom < -1300) {
    if (ui.isSolar()) {
      zoom = -100;
      ui.toggleSolar();
    }
  }
  if (ui.isSolar()) {
    if (zoom > 666)
      zoom = 666;
  }
  if(!ui.isSolar()) {
    if(zoom < -1000)
        zoom = -1000;
  }
}

public void mousePressed() {
  if (ui.getShowInfo()) {
    ui.toggleInfo();
  } else {
    if (ui.clickFilters(mouseX, mouseY)) {
      earth.countNodes();
      moon.countNodes();
      mars.countNodes();
      if(web)
        javascript.refreshResults();
    } else {
      dragY = mouseY;
      dragX = mouseX;
    }
  }
}

public void mouseDragged() {
  panY = panY + (mouseY - dragY);
  if (mouseY > dragY) {
    panY = panY + (mouseY - dragY);
    dragY = mouseY;
  } else {
    panY = panY - (dragY - mouseY);
    dragY = mouseY;
  }
  if (mouseX > dragX) {
    panX = panX + (mouseX - dragX);
    dragX = mouseX;
  } else {
    panX = panX - (dragX - mouseX);
    dragX = mouseX;
  }
}

public void draw() {
  if (!web)
    background(bg);
  else
    background(0);

  beginCamera();
  camera(width/2, height/2, 0, 
  width/2, height/2, -2000, 
  0.0f, 1.0f, 0.0f);

  //start drawing model
  pushMatrix();//0
  //translate to center of screen, and a far away perspective
  translate(width/2, height/2, -2000);
  //pan horizontal
  translate(panX, 0, zoom);
  //pan vertical 
  rotateX(radians(-20));
  translate(0, 0, panY);

  if (ui.isSolar()) {
    drawPlanets();
    nodeHandler.drawNodes();
  } else {
    drawGalaxy();
    nodeHandler.drawNodes();
  }
  //stop drawing model
  endCamera();
  popMatrix();

  //reset camera so UI can be drawn accurately
  camera();
  ui.draw();
}

public void drawPlanets() {
  pushMatrix();
  earth.draw();
  moon.draw();
  mars.draw();
  popMatrix();
}

public void drawGalaxy() {
  pushMatrix();
  rotateX(radians(90));
  ellipseMode(CENTER);
  noFill();
  stroke(255);
  translate(0, -35, -35);

  ellipse(0, 0, 2400, 2400);
  if (!web) {
    imageMode(CENTER);
    tint(255, 210);
    image(mwgImg, 0, 0, 2400, 2400);
    noTint();
  } else {
    
  }


  imageMode(CORNER);
  popMatrix();
}

class Filter {

  Filter() {
  }
  //publication date
  public int filterPublished(Node node) {
    if (node.published <= 1969) {
      return 0;
    } else if ((node.published > 1969) & (node.published <= 1990)) {
      return 1;
    } else {
      return 2;
    }
  }
  //Time categories relevant to the work itself
  public boolean filterPastWork(Node node) {
    if (node.isPastWork()) {
      return true;
    }
    else
      return false;
  }

  //Time categories relevant to the user
//  int filterTimeForUser(Node node) {
//    if (node.tags[12] == 40) {
//      return 40;
//    } else if (node.tags[13] == 41) {
//      return 41;
//    } else if (node.tags[14] == 42) {
//      return 42;
//    }
//  }
}

class Node {

  float distance;
  float angle;

  PFont font = loadFont("largeFont.vlw");

  String novel;
  String author;
  int published;
  String dateOfActionWork;
  String dateOfActionUser;
  String locationOfAction;

  boolean earthNode = false;
  boolean marsNode = false;
  boolean moonNode = false;
  boolean inSolarSystem = false;
  boolean outsideSolarSystem = false;
  boolean outsideMWG = false;

  boolean fictionalLocation = false;
  boolean gender;//false - female; true - male

  boolean dateWork1 = false;//past
  boolean dateWork2 = false;//contemporary
  boolean dateWork3 = false;//near future
  boolean dateWork4 = false;//distant future
  boolean dateWork5 = false;//n/a

  boolean dateUser1 = false;//20th century and before
  boolean dateUser2 = false;//21st century
  boolean dateUser3 = false;//22nd century and beyond

  Node() {
    distance = 450;
    angle = random(360);
  }

  Node(String novelSet, String authorSet, int publishedSet, String dateOfActionWorkSet, String dateOfActionUserSet, String locationOfActionSet, int[] tags) {
    novel = novelSet;
    author = authorSet;
    published = publishedSet;
    dateOfActionWork = dateOfActionWorkSet;
    dateOfActionUser = dateOfActionUserSet;
    locationOfAction = locationOfActionSet;
    for (int i=0; i<tags.length; i++) {
      if (tags[i] == 1) {
        earthNode = true;
      }
      if (tags[i] == 2) {
        marsNode = true;
      }
      if (tags[i] == 3) {
        moonNode = true;
      }
      if (tags[i] == 4) {
        inSolarSystem = true;
      }
      if (tags[i] == 5) {
        outsideSolarSystem = true;
      }
      if (tags[i] == 6) {
        outsideMWG = true;
      }
      if (tags[i] == 10) {
        fictionalLocation = true;
      }
      if (tags[i] == 20) {
        gender = false;
      }
      if (tags[i] == 21) {
        gender = true;
      }
      if (tags[i] == 30) {
        dateWork1 = true;
      }
      if (tags[i] == 31) {
        dateWork2 = true;
      }
      if (tags[i] == 32) {
        dateWork3 = true;
      }
      if (tags[i] == 33) {
        dateWork4 = true;
      }
      if (tags[i] == 34) {
        dateWork5 = true;
      }
      if (tags[i] == 40) {
        dateUser1 = true;
      }
      if (tags[i] == 41) {
        dateUser2 = true;
      }
      if (tags[i] == 42) {
        dateUser3 = true;
      }
    }
    if (outsideMWG) {
      angle = random(360);
      distance = 1400 + random(250);
      while (nodeHandler.isNear (this)) {
        angle = random(360);
        distance = 1400 + random(250);
      }
    } else {
      if (outsideSolarSystem) {
        angle = random(360);
        distance = 150 + random(900);
        while (nodeHandler.isNear (this)) {
          angle = random(360);
          distance = 150 + random(900);
        }
      }
    }
    if (inSolarSystem) {
      float changingDistance = 200;
      if (!outsideSolarSystem)
        changingDistance += 650;
      angle = random(360);
      distance = 600 + random(changingDistance);
      while (nodeHandler.isNear (this)) {
        angle = random(360);
        distance = 800 + random(changingDistance);
      }
    }
  }

  Node (String novelSet) {
    novel = novelSet; 
    distance = 200 + random(1000);
    angle = random(360);
  }

  public void draw() {
    //    if (!earthNode && !moonNode && !marsNode) {
    if (inSolarSystem || outsideSolarSystem || outsideMWG) {
      noStroke();
      fill(255);
      rotateY(radians(angle));

      translate(distance, 0, 0);
      sphere(25);

      rotateY(radians(360-angle));
      translate(0, -80, 40);
      fill(255);
      textFont(font, 32);
      textAlign(CENTER);
      text(novel, 0, 0);
      textAlign(CORNER);
      //    } else {
      //      //if earth,moon,mars is being hovered, draw....
      //    }
    }
  }

  public String getNovel() {
    return novel;
  }

  public boolean contains(String search) {
    if (novel.toLowerCase().indexOf(search.toLowerCase()) != -1 || author.toLowerCase().indexOf(search.toLowerCase()) != -1) {
      return true;
    } else {
      return false;
    }
  }

  public boolean isEarthNode() {
    return earthNode;
  }

  public boolean isMoonNode() {
    return moonNode;
  }

  public boolean isMarsNode() {
    return marsNode;
  }

  public boolean isInsideSS() {
    return inSolarSystem;
  }

  public boolean isOutsideSS() {
    return outsideSolarSystem;
  }

  public boolean isOutsideMWG() {
    return outsideMWG;
  }

  public boolean isFictionalLocation() {
    return fictionalLocation;
  }

  public boolean getGender() {
    return gender;
  }

  public boolean isPastWork() {
    return dateWork1;
  }

  public boolean isContemporaryWork() {
    return dateWork2;
  }

  public boolean isNearFutureWork() {
    return dateWork3;
  }

  public boolean isDistantFutureWork() {
    return dateWork4;
  }

  public boolean isNAWork() {
    return dateWork5;
  }

  public boolean isPastUser() {
    return dateUser1;
  }

  public boolean isPresentUser() {
    return dateUser2;
  }

  public boolean isFutureUser() {
    return dateUser3;
  }

  public String getInfo() {
    String returnString = "<h4>" + novel + " (" + published + ")</h4><br>  " + author;
    boolean listStarted = false;
    if (gender) {
      returnString = returnString + " (M)";
    } else {
      returnString = returnString + " (F)";
    }
    returnString = returnString + "<br>  Date Of Action: " + dateOfActionWork + "<br>  Location: " + locationOfAction + "<br> Tags: "; 
    if (isFictionalLocation()) {
      if (listStarted) {
        returnString = returnString + ", ";
      } else {
        listStarted = true;
      }
      returnString = returnString + "Fictional Location";
    }
    if (isNAWork()) {
      if (listStarted) {
        returnString = returnString + ", ";
      } else {
        listStarted = true;
      }
      returnString = returnString + "Outside of Time";
    }
    if (isContemporaryWork()) {
      if (listStarted) {
        returnString = returnString + ", ";
      } else {
        listStarted = true;
      }
      returnString = returnString + "Contemporary";
    }
    return returnString;
  }

  public boolean intersect(Node node) {
    if (abs(this.angle - node.angle) < 25) {
      if (abs(this.distance - node.distance) < 250) {
        return true;
      } else return false;
    } else return false;
  }
}

/* TAGS:
 01 - Earth
 02 - Mars
 03 - Moon
 04 - solar system
 05 - OSS (outside solar system)
 06 - OMWG (outside milky way galaxy)
 
 10 - Fictional Location
 
 M (21)- Male
 F (20)- Female
 
 30 - Past
 31 - Contemporary
 32 - Near Future
 33 - Distant Future
 34 - N/A
 
 40 - 20th Century & Earlier
 41 - Present (21st Century)
 42 - 22nd Century & Beyond
 */

//functions have to be outside of class for javascript to "see" it.
public void addNode(String novel, String author, int published, String dateOfAction, String locationOfAction, int[] tags) {
  nodeHandler.addNode(novel, author, published, dateOfAction, locationOfAction, tags);
}

public Node[] searchNodes(String search) {
  return nodeHandler.searchNodes(search);
}

public void analyzeNodes() {
  nodeHandler.analyzeNodes();
}

public Node[] getEarthNodes() {
  return nodeHandler.getEarthNodes();
}

public Node[] getMoonNodes() {
  return nodeHandler.getMoonNodes();
}

public Node[] getMarsNodes() {
  return nodeHandler.getMarsNodes();
}

public void published1() {
  println("hellooo");
  nodeHandler.togglePublished(1);
}

class NodeHandler {

  ArrayList<Node> nodes = new ArrayList<Node>();
  Filter theFilter = new Filter();
  boolean[] published = new boolean[3];//0 - pre-1969; 1 - 1969-1990; 2 - post-1990
  boolean[] dateOfActionWork = new boolean[5]; //0 - Past, 1 - Contemporary, 2 - Near Future, 3 - Distant Future, 4 - N/A
  boolean[] dateOfActionUser = new boolean[3]; //0 - 20th Century & earlier, 1 - Present, 2 - 22nd Century and Beyond
  //  boolean[] filter = new boolean[3]; //0 - filter by published, 1 - filter by date for work, 2 - filter by date for user

  int novelCount = 0;
  int earthCount = 0;
  int moonCount = 0;
  int marsCount = 0;

  int insideSSCount = 0;
  int outsideSSCount = 0;
  int outsideMWGCount = 0;

  int fictionCount = 0;
  int femaleCount = 0;
  int maleCount = 0;

  int pastCount = 0;
  int contemporaryCount = 0;
  int nearFutureCount = 0;
  int distantFutureCount = 0;
  int naCount = 0;

  int userPastCount = 0;
  int userPresentCount = 0;
  int userFutureCount = 0;

  NodeHandler() {
    published[0] = true;
    published[1] = true;
    published[2] = true;

    dateOfActionWork[0] = true;
    dateOfActionWork[1] = true;
    dateOfActionWork[2] = true;
    dateOfActionWork[3] = true;
    dateOfActionWork[4] = true;

    dateOfActionUser[0] = true;
    dateOfActionUser[1] = true;
    dateOfActionUser[2] = true;
  }

  public void drawNodes() {
    for (int i=0; i<nodes.size (); i++) {
      pushMatrix();

      if (checkFilters(nodes.get(i))) {
        if (ui.isSolar() && nodes.get(i).isInsideSS()) {
          nodes.get(i).draw();
        } else if (!ui.isSolar() && nodes.get(i).isOutsideSS()) {
          nodes.get(i).draw();
        }
      }
      popMatrix();
    }
  }

  public void addNode(String novel, String author, int published, String dateOfAction, String locationOfAction, int[] tags) {
    nodes.add(new Node(novel, author, published, dateOfAction, dateOfAction, locationOfAction, tags));
    if (DEBUG) {
      println("N: " + novel + " A: " + author + " P: " + published + " L: " + locationOfAction);
    }
    novelCount++;
  }

  public void parseTable(String tableName) {
    Table table = loadTable(tableName, "header");

    for (TableRow row : table.rows ()) {
      String novel = row.getString(0);
      String author  = row.getString(1);
      int published = row.getInt(2);
      String dateOfAction = row.getString(3);
      String locationOfAction = row.getString(4);

      String tagsString = row.getString(5);
      int[] tags = new int[16];
      if (tagsString.indexOf("01") != -1) {
        tags[0] = 1;
      }
      if (tagsString.indexOf("02") != -1) {
        tags[1] = 2;
      } 
      if (tagsString.indexOf("03") != -1) {
        tags[2] = 3;
      } 
      if (tagsString.indexOf("04") != -1) {
        tags[3] = 4;
      } 
      if (tagsString.indexOf("05") != -1) {
        tags[4] = 5;
      } 
      if (tagsString.indexOf("10") != -1) {
        tags[5] = 10;
      } 
      if (tagsString.indexOf("F") != -1) {
        tags[6] = 20;
      } else if (tagsString.indexOf("M") != -1) {
        tags[6] = 21;
      }
      if (tagsString.indexOf("30") != -1) {
        tags[7] = 30;
      }
      if (tagsString.indexOf("31") != -1) {
        tags[8] = 31;
      }
      if (tagsString.indexOf("32") != -1) {
        tags[9] = 32;
      }
      if (tagsString.indexOf("33") != -1) {
        tags[10] = 33;
      }
      if (tagsString.indexOf("34") != -1) {
        tags[11] = 34;
      }
      if (tagsString.indexOf("40") != -1) {
        tags[12] = 40;
      }
      if (tagsString.indexOf("41") != -1) {
        tags[13] = 41;
      }
      if (tagsString.indexOf("42") != -1) {
        tags[14] = 42;
      }
      if (tagsString.indexOf("06") != -1) {
        tags[15] = 6;
      } 

      nodes.add(new Node(novel, author, published, dateOfAction, dateOfAction, locationOfAction, tags));
      if (DEBUG) {
        println("added " + novel);
      }
      novelCount++;
    }

    analyzeNodes();
  }

  public Node[] searchNodes(String search) {
    ArrayList<Node> returnedNodes = new ArrayList<Node>();
    for (int i=0; i<nodes.size (); i++) {
      if (nodes.get(i).contains(search)) {
        returnedNodes.add(nodes.get(i));
      }
    }
    Node[] convertedNodes = new Node[returnedNodes.size()];
    for (int i=0; i<returnedNodes.size (); i++) {
      convertedNodes[i] = returnedNodes.get(i);
    }

    return convertedNodes;
  }

  public String[] getStatistics() {
    float novelCountFixed = novelCount;
    if (novelCountFixed == 0) {
      novelCountFixed = 1;
    }

    String[] stats = new String[17];
    stats[0] = "Novels: " + novelCount;
    stats[1] = "Earth: " + earthCount + " (" + nf((((float)earthCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[2] = "Moon: " + moonCount + " (" + nf((((float)moonCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[3] = "Mars: " + marsCount + " (" + nf((((float)marsCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[4] = "Inside Solar System: " + insideSSCount + " (" + nf((((float)insideSSCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[5] = "Outside Solar System: " + outsideSSCount + " (" + nf((((float)outsideSSCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[6] = "Fictional Location: " + fictionCount + " (" + nf((((float)fictionCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[7] = "Female Author: " + femaleCount + " (" + nf((((float)femaleCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[8] = "Male Author: " + maleCount + " (" + nf((((float)maleCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[9] = "Past Work: " + pastCount + " (" + nf((((float)pastCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[10] = "Contemporary Work: " + contemporaryCount + " (" + nf((((float)contemporaryCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[11] = "Near Future Work: " + nearFutureCount + " (" + nf((((float)nearFutureCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[12] = "Distant Future Work: " + distantFutureCount + " (" + nf((((float)distantFutureCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[13] = "N/A Work: " + naCount + " (" + nf((((float)naCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[14] = "20th Century & Before: " + userPastCount + " (" + nf((((float)userPastCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[15] = "21st Century: " + userPresentCount + " (" + nf((((float)userPresentCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[16] = "22nd Century & Beyond: " + userFutureCount + " (" + nf((((float)userFutureCount / novelCountFixed) * 100), 1, 2) + "%)";
    return stats;
  }

  public void analyzeNodes() {
    novelCount = 0;
    earthCount = 0;
    moonCount = 0;
    marsCount = 0;
    insideSSCount = 0;
    outsideSSCount = 0;
    outsideMWGCount = 0;
    fictionCount = 0;
    femaleCount = 0;
    maleCount = 0;
    pastCount = 0;
    contemporaryCount = 0;
    nearFutureCount = 0;
    distantFutureCount = 0;
    naCount = 0;
    userPastCount = 0;
    userPresentCount = 0;
    userFutureCount = 0;

    for (int i=0; i<nodes.size (); i++) {
      if (checkFilters(nodes.get(i))) {

        if (nodes.get(i).isEarthNode()) {
          earthCount++;
        }  
        if (nodes.get(i).isMoonNode()) {
          moonCount++;
        }  
        if (nodes.get(i).isMarsNode()) {
          marsCount++;
        }  
        if (nodes.get(i).isInsideSS()) {
          insideSSCount++;
        }  
        if (nodes.get(i).isOutsideSS()) {
          outsideSSCount++;
        }  
        if (nodes.get(i).isOutsideMWG()) {
          outsideMWGCount++;
        }
        if (nodes.get(i).isFictionalLocation()) {
          fictionCount++;
        }
        if (nodes.get(i).getGender()) {
          maleCount++;
        } else {
          femaleCount++;
        }
        if (nodes.get(i).isPastWork()) {
          pastCount++;
        }
        if (nodes.get(i).isContemporaryWork()) {
          contemporaryCount++;
        }
        if (nodes.get(i).isNearFutureWork()) {
          nearFutureCount++;
        }
        if (nodes.get(i).isDistantFutureWork()) {
          distantFutureCount++;
        }
        if (nodes.get(i).isNAWork()) {
          naCount++;
        }
        if (nodes.get(i).isPastUser()) {
          userPastCount++;
        }
        if (nodes.get(i).isPresentUser()) {
          userPresentCount++;
        }
        if (nodes.get(i).isFutureUser()) {
          userFutureCount++;
        }
        novelCount++;
      }
    }
  }

  //  Node[] getAllNodes() {
  //     return nodes;
  //  }

  public Node[] getEarthNodes() {
    Node[] earthNodes = new Node[earthCount];
    int count = 0;
    for (int i=0; i<nodes.size (); i++) {
      if (checkFilters(nodes.get(i))) {
        if (nodes.get(i).isEarthNode()) {
          earthNodes[count] = nodes.get(i);
          count++;
        }
      }
    }
    return earthNodes;
  }

  public Node[] getMoonNodes() {
    Node[] moonNodes = new Node[moonCount];
    int count = 0;
    for (int i=0; i<nodes.size (); i++) {
      if (checkFilters(nodes.get(i))) {
        if (nodes.get(i).isMoonNode()) {
          moonNodes[count] = nodes.get(i);
          count++;
        }
      }
    }
    return moonNodes;
  }

  public Node[] getMarsNodes() {
    Node[] marsNodes = new Node[marsCount];
    int count = 0;
    for (int i=0; i<nodes.size (); i++) {
      if (checkFilters(nodes.get(i))) {
        if (nodes.get(i).isMarsNode()) {
          marsNodes[count] = nodes.get(i);
          count++;
        }
      }
    }
    return marsNodes;
  }
  //
  //  Node[] getInsideSSNodes() {
  //  }
  //
  //  Node[] getOutsideSSNodes() {
  //  }
  //
  //  Node[] getFictionalNodes() {
  //  }

  public int getEarthCount() {
    return earthCount;
  }

  public int getMoonCount() {
    return moonCount;
  }

  public int getMarsCount() {
    return marsCount;
  }

  //void toggleFilter (int selection) {
  //  filter[selection] = !filter[selection];
  //}
  public void togglePublished(int selection) {
    published[selection] = !published[selection];
    analyzeNodes();
  }

  public void toggleDateofActionWork(int selection) {
    dateOfActionWork[selection] = !dateOfActionWork[selection];
    analyzeNodes();
  }

  public void toggleDateofActionUser(int selection) {
    dateOfActionUser[selection] = !dateOfActionUser[selection];
    analyzeNodes();
  }

  public boolean getPublished(int selection) {
    return published[selection];
  }

  public boolean getDateOfActionWork(int selection) {
    return dateOfActionWork[selection];
  }

  public boolean getDateOfActionUser(int selection) {
    return dateOfActionUser[selection];
  }


  public boolean checkFilters(Node node) {
    if ((published[0] && theFilter.filterPublished(node) == 0) ||
      (published[1] && theFilter.filterPublished(node) == 1) ||
      (published[2] && theFilter.filterPublished(node) == 2)) { 
      if ((dateOfActionWork[0] &&  node.isPastWork()) ||
        (dateOfActionWork[1] && node.isContemporaryWork()) ||
        (dateOfActionWork[2] && node.isNearFutureWork()) ||
        (dateOfActionWork[3] && node.isDistantFutureWork()) ||
        (dateOfActionWork[4] && node.isNAWork())) {
        if ((dateOfActionUser[0] && node.isPastUser()) ||
          (dateOfActionUser[1] && node.isPresentUser()) ||
          (dateOfActionUser[2] && node.isFutureUser()) ||
          (dateOfActionWork[4] && node.isNAWork())) {
          return true;
        } else return false;
      } else return false;
    } else return false;
  }

  public boolean isNear(Node node) {
    boolean check = false;
    if (node.isInsideSS()) {
      for (int i=0; i<nodes.size (); i++) {
        if (nodes.get(i).isInsideSS()) {
          if (node.intersect(nodes.get(i))) {
//            println("too close: " + node.angle + " : " + nodes.get(i).angle + ", " + node.distance + " : " + nodes.get(i).distance);
            check = true;
          }
        }
      }
    } else if (node.isOutsideSS()) {
      for (int i=0; i<nodes.size (); i++) {
        if (nodes.get(i).isOutsideSS()) {
          if (node.intersect(nodes.get(i))) {
            check = true;
          }
        }
      }
    } else if (node.isOutsideMWG()) {
      for (int i=0; i<nodes.size (); i++) {
        if (nodes.get(i).isOutsideMWG()) {
          if (node.intersect(nodes.get(i))) {
            check = true;
          }
        }
      }
    }
    return check;
  }
}

class Planet {

  PImage image;
  float radius = 200;
  float rotation = 0;
  float rotationSpeed = .5f;
  int nodeCount = 0;

  Planet() {
  }

  Planet(PImage image) {
    this.image = image;
  }

  public void draw() {
    pushMatrix();
    rotateY(radians(rotation));
    noStroke();
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    rotatePlanet();
  } 

  public void say() {
    println("I'm a generic planet!");
  }

  public void rotatePlanet() {
    rotation += rotationSpeed;
    if (rotation >= 360) {
      rotation = 0;
    }
  }

  public void countNodes() {
    //unimplemented in default Planet
  }
}

class OrbitingPlanet extends Planet {
  float orbitAngle;
  float orbitHeight;
  float orbitSpeed;

  OrbitingPlanet() {
  }

  public void draw() {
    pushMatrix();
    rotateY(radians(rotation));
    noStroke();
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    rotatePlanet();
    incrementOrbit();
  }

  OrbitingPlanet(PImage image) {
    this.image = image;
  }

  public void incrementOrbit() {
    orbitAngle += orbitSpeed;
    if (orbitAngle >= 360) {
      orbitAngle = 0;
    }
  }
}

class Earth extends Planet {

  Earth() {
    countNodes();
  }

  Earth(PImage image) {
    this.image = image;
    countNodes();
  }

  public void draw() {
    pushMatrix();
    rotateY(radians(rotation));
    noStroke();
    radius = (nodeCount * 4) + 100;
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    rotatePlanet();
  }

  public void say() {
    println("I'm the Earth, the best planet ever!");
  }

  public void countNodes() {
    nodeCount = nodeHandler.getEarthCount();
  }
}

class Moon extends OrbitingPlanet {

  Moon() {
    radius = 55;
    rotationSpeed = 0;
    orbitAngle = 150;
    orbitHeight = 1200;
    orbitSpeed = .02f;
  }

  Moon(PImage image) {
    this.image = image;
    radius = 55;
    rotationSpeed = 0;
    orbitAngle = 150;
    orbitHeight = 1200;
    orbitSpeed = .25f;
  }

  public void say() {
    println("I'm the Moon, I like to hang out with the best planet ever!");
  }

  public void draw() {
    pushMatrix();
    pushMatrix();

    rotateX(radians(90));

    ellipseMode(CENTER);
    noFill();
    stroke(255);
    ellipse(0, 0, orbitHeight*2, orbitHeight*2);

    popMatrix();

    rotateY(radians(orbitAngle));
    translate(orbitHeight, 0, 0);

    rotateY(radians(60));

    noStroke();
    radius = (nodeCount * 25) + 50;
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    incrementOrbit();
    rotatePlanet();
  }

  public void countNodes() {
    nodeCount = nodeHandler.getMoonCount();
  }
}

class Mars extends OrbitingPlanet {

  Mars() {
    radius = 107;
    rotationSpeed = 0.4f;
    orbitAngle = 85;
    orbitHeight = 6000;
    orbitSpeed = .003f;
  }

  Mars(PImage image) {
    this.image = image;
    radius = 107;
    rotationSpeed = 0.4f;
    orbitAngle = 85;
    orbitHeight = 6000;
    orbitSpeed = .03f;
  }

  public void draw() {
    pushMatrix();
    translate(2500, 0, 2000);

    pushMatrix();
    rotateX(radians(90));
    ellipseMode(CENTER);
    noFill();
    stroke(255);
    ellipse(0, 0, orbitHeight*2, orbitHeight*2);
    popMatrix();

    rotateY(radians(orbitAngle));
    translate(orbitHeight, 0, 0);

    rotateY(radians(rotation));
    noStroke();
    radius = (nodeCount * 15) + 200;
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    rotatePlanet();
    incrementOrbit();
  }

  public void say() {
    println("I'm Mars! In about 300 years, I'll be the best planet ever!");
  }

  public void countNodes() {
    nodeCount = nodeHandler.getMarsCount();
  }
}

// textureSphere code from: https://processing.org/examples/texturesphere.html
int ptsW, ptsH;
int numPointsW;
int numPointsH_2pi; 
int numPointsH;
float[] coorX;
float[] coorY;
float[] coorZ;
float[] multXZ;

public void prepSphere() {
  //initialize variables
  // Parameters below are the number of vertices around the width and height
  ptsW=30;
  ptsH=30;
  initializeSphere(ptsW, ptsH);
}

public void initializeSphere(int numPtsW, int numPtsH_2pi) {

  // The number of points around the width and height
  numPointsW=numPtsW+1;
  numPointsH_2pi=numPtsH_2pi;  // How many actual pts around the sphere (not just from top to bottom)
  numPointsH=ceil((float)numPointsH_2pi/2)+1;  // How many pts from top to bottom (abs(....) b/c of the possibility of an odd numPointsH_2pi)

  coorX=new float[numPointsW];   // All the x-coor in a horizontal circle radius 1
  coorY=new float[numPointsH];   // All the y-coor in a vertical circle radius 1
  coorZ=new float[numPointsW];   // All the z-coor in a horizontal circle radius 1
  multXZ=new float[numPointsH];  // The radius of each horizontal circle (that you will multiply with coorX and coorZ)

  for (int i=0; i<numPointsW; i++) {  // For all the points around the width
    float thetaW=i*2*PI/(numPointsW-1);
    coorX[i]=sin(thetaW);
    coorZ[i]=cos(thetaW);
  }

  for (int i=0; i<numPointsH; i++) {  // For all points from top to bottom
    if (PApplet.parseInt(numPointsH_2pi/2) != (float)numPointsH_2pi/2 && i==numPointsH-1) {  // If the numPointsH_2pi is odd and it is at the last pt
      float thetaH=(i-1)*2*PI/(numPointsH_2pi);
      coorY[i]=cos(PI+thetaH); 
      multXZ[i]=0;
    } else {
      //The numPointsH_2pi and 2 below allows there to be a flat bottom if the numPointsH is odd
      float thetaH=i*2*PI/(numPointsH_2pi);

      //PI+ below makes the top always the point instead of the bottom.
      coorY[i]=cos(PI+thetaH); 
      multXZ[i]=sin(thetaH);
    }
  }
}

public void textureSphere(float rx, float ry, float rz, PImage t) { 
  // These are so we can map certain parts of the image on to the shape 
  float changeU=t.width/(float)(numPointsW-1); 
  float changeV=t.height/(float)(numPointsH-1); 
  float u=0;  // Width variable for the texture
  float v=0;  // Height variable for the texture

  beginShape(TRIANGLE_STRIP);
  texture(t);
  for (int i=0; i< (numPointsH-1); i++) {  // For all the rings but top and bottom
    // Goes into the array here instead of loop to save time
    float coory=coorY[i];
    float cooryPlus=coorY[i+1];

    float multxz=multXZ[i];
    float multxzPlus=multXZ[i+1];

    for (int j=0; j<numPointsW; j++) {  // For all the pts in the ring
      normal(coorX[j]*multxz, coory, coorZ[j]*multxz);
      vertex(coorX[j]*multxz*rx, coory*ry, coorZ[j]*multxz*rz, u, v);
      normal(coorX[j]*multxzPlus, cooryPlus, coorZ[j]*multxzPlus);
      vertex(coorX[j]*multxzPlus*rx, cooryPlus*ry, coorZ[j]*multxzPlus*rz, u, v+changeV);
      u+=changeU;
    }
    v+=changeV;
    u=0;
  }
  endShape();
}
class UI {

  PFont font;
  boolean showStats = true;
  boolean showControls = true;
  boolean showFilters = true;
  boolean showInfo = true;

  boolean solarMode = true;


  int textColor = color(255);
  int bgColor = color(90, 90, 90);

  UI() {
    font = createFont("Facet", 24);
  }

  public void draw() {
    float webSpace;
    if (!web) {
      webSpace = 20;
    } else {
      webSpace = 12;
    }
    pushMatrix();
    stroke(textColor);
    if (!web) {
      fill(bgColor);
      rect(-1, 0, width+1, 30);
    } else {
      //          translate(0, 0, 30);
      noFill();
      rect(-1, 0, width+1, 30);
      //          translate(0,0,5);
    }
    textFont(font, 20);
    fill(255);
    //text("Visualizing our Imaginative Universe", 10, 20);
    line(300, 0, 300, 30);
    line(700, 0, 700, 30);
    line(1000, 0, 1000, 30);
    //line(850, 0, 850, 30);
    if (showStats) {
      textFont(font, 20);
      text("Statistics [-]", 10, webSpace);
      pushMatrix();
      translate(0, 30, 0);

      fill(bgColor);
      rect(0, 0, 300, 280);
      if (!web) {
      } else {
        translate(5, 0, 15);
      }
      fill(textColor);
      textFont(font, 16);
      translate(0, 3, 0);
      for (String stat : nodeHandler.getStatistics ()) {
        translate(0, 15, 0);
        text(stat, 8, 0);
      }
      popMatrix();
    } else {
      textFont(font, 20);
      text("Statistics [+]", 10, webSpace);
    }
    if (showFilters) {
      textFont(font, 20);
      text("Filters [-]", 310, webSpace);
      pushMatrix();
      /*if (!showStats) {
       translate(-300, 0, 0);
       } else {
       translate(0, 0, 0);
       }*/


      drawFilterBox();
      popMatrix();
    } else {
      textFont(font, 20);
      text("Filters [+]", 310, webSpace);
    }
    if (showControls) {
      textFont(font, 20);
      text("Controls [-]", 710, webSpace);
      pushMatrix();
      translate(0, 30, 0);
      /*if (!showStats) {
       if (!showFilters) {
       translate(-700, 0, 0);
       } else {
       translate(-400, 0, 0);
       }
       } else {
       translate(0, 0, 0);
       }*/

      stroke(textColor);
      fill(bgColor);
      rect(700, 0, 300, 100);
      if (!web) {
      } else {
        translate(5, 0, 15);
      }

      fill(textColor);
      textFont(font, 16);
      translate(0, 18, 0);
      text("Arrow Keys (Mouse Drag) : Pan", 708, 0);
      text("Mouse Wheel : Zoom", 708, 15);
      text("Show/Hide Statistics : S", 708, 30);
      text("Show/Hide Controls : C", 708, 45);
      text("Show/Hide Filters : F", 708, 60);
      popMatrix();
    } else {
      textFont(font, 20);
      text("Controls [+]", 710, webSpace);
    }
    if (showInfo) {
      textFont(font, 20);
      text("Info [-]", 1010, webSpace);
      pushMatrix();
      translate(0, 8, 16);
      noStroke();
      fill(bgColor);
      rect(0, 31, width, height);
      if (!web) {
      } else {
        translate(0, 0, 25);
      }

      tint(255);

      fill(textColor);
      translate(0, 31, 0);

      textAlign(CENTER);
      textFont(font, 36);
      text("Visualizing Our Imaginative Universe", (width/2), 90);
      textFont(font, 20);
      text("Created by Haley Hiers, Kali Ruppert, & Jordan Silver", width/2, 180);

      text("    Hugo and Nebula award-winning novels have been analyzed to reveal several\ncrucial pieces of information:  date of publication, date of action, and place of action.  In\ncapturing and visualizing this data, we can reveal how the literary imagination shapes the\nuniverse in three time periods.  Before the Moon Landing (1969), in the period following\nthe moon landing and preceding the launching of the Hubble telescope (1969-1989),\nand after the launching of the Hubble to the present day, looking at where (and when)\nfictional representations situate humanity. This generates valuable insight into the \nhopes and fears of English-speaking society about the future of our world.", width/2, 240);

      text("Press any key to close", width/2, 560);

      textAlign(LEFT);

      popMatrix();
    } else {
      textFont(font, 20);
      text("Info [+]", 1010, webSpace);
    }
    popMatrix();
  }

  public void drawFilterBox() {
    pushMatrix(); 
    translate(300, 30, 0);
    fill(bgColor);
    rect(0, 0, 400, 150);
    if (!web) {
    } else {
      translate(5, 0, 15);
    }
    fill(textColor);
    textFont(font, 13);
    text("Published", 8, 18);
    for (int i=0; i<3; i++) {
      float x = 10;
      float y = 25 + 25*i;
      float l = 15;
      stroke(0);
      fill(255);
      rect(x, y, l, l);
      if (nodeHandler.getPublished(i)) {
        line(x, y, x+l, y+l);
        line(x+l, y, x, y+l);
      }
      fill(255);
      if (i == 0) {
        text("Pre-1969", x+l+5, y+10);
      } else if (i == 1) {
        text("1969-1990", x+l+5, y+10);
      } else if (i == 2) {
        text("Post-1990", x+l+5, y+10);
      }
    }

    text("DateOfActionWork", 108, 18);
    for (int i=0; i<5; i++) {
      float x = 110;
      float y = 25 + 25*i;
      float l = 15;
      stroke(0);
      rect(x, y, l, l);
      if (nodeHandler.getDateOfActionWork(i)) {
        line(x, y, x+l, y+l);
        line(x+l, y, x, y+l);
      }
      if (i == 0) {
        text("Past", x+l+5, y+10);
      } else if (i == 1) {
        text("Contemporary", x+l+5, y+10);
      } else if (i == 2) {
        text("Near Future", x+l+5, y+10);
      } else if (i == 3) {
        text("Distant Future", x+l+5, y+10);
      } else if (i == 4) {
        text("N/A", x+l+5, y+10);
      }
    }

    text("DateOfActionUser", 228, 18);
    for (int i=0; i<3; i++) {
      float x = 230;
      float y = 25 + 25*i;
      float l = 15;
      stroke(0);
      rect(x, y, l, l);
      if (nodeHandler.getDateOfActionUser(i)) {
        line(x, y, x+l, y+l);
        line(x+l, y, x, y+l);
      }
      if (i == 0) {
        text("20th Century & Before", x+l+5, y+10);
      } else if (i == 1) {
        text("21st Century", x+l+5, y+10);
      } else if (i == 2) {
        text("22nd Century & Beyond", x+l+5, y+10);
      }
    }
    popMatrix();
  }

  public boolean clickFilters(float x, float y) {
    if (x >= 310 && x <= 325) {
      if (y >= 58 && y <= 73) {
        nodeHandler.togglePublished(0);
        return true;
      } else if (y >= 83 && y <= 98) {
        nodeHandler.togglePublished(1);
        return true;
      } else if (y >= 108 && y <= 123) {
        nodeHandler.togglePublished(2);
        return true;
      } else {
        return false;
      }
    } else if (x >= 410 && x <= 425) {
      if (y >= 58 && y <= 73) {
        nodeHandler.toggleDateofActionWork(0);
        return true;
      } else if (y >= 83 && y <= 98) {
        nodeHandler.toggleDateofActionWork(1);
        return true;
      } else if (y >= 108 && y <= 123) {
        nodeHandler.toggleDateofActionWork(2);
        return true;
      } else if (y >= 133 && y <= 148) {
        nodeHandler.toggleDateofActionWork(3);
        return true;
      } else if (y >= 158 && y <= 173) {
        nodeHandler.toggleDateofActionWork(4);
        return true;
      } else {
        return false;
      }
    } else if (x >= 530 && x <= 545) {
      if (y >= 58 && y <= 73) {
        nodeHandler. toggleDateofActionUser(0);
        return true;
      } else if (y >= 83 && y <= 98) {
        nodeHandler. toggleDateofActionUser(1);
        return true;
      } else if (y >= 108 && y <= 123) {
        nodeHandler. toggleDateofActionUser(2);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  public boolean clickToggles(float x, float y) {
    if (y <= 30) {
      if (x <= 300) {
        toggleStats();
        return true;
      } else if (x <= 700) {
        toggleFilters();
        return true;
      } else if (x <= 1000) {
        toggleControls();
        return true;
      } else {
        toggleInfo();
        return true;
      }
    } else {
      return false;
    }
  }

  public void toggleStats() {
    showStats = !showStats;
  }

  public void toggleControls() {
    showControls = !showControls;
  }

  public void toggleFilters() {
    showFilters = !showFilters;
  }

  public void toggleInfo() {
    showInfo = !showInfo;
    if(javascript!=null) {
      if (showInfo)
        javascript.hideBar();
      else {
        javascript.showBar();
      }
    }
  }

  public boolean getShowInfo() {
    return showInfo;
  }

  public boolean isSolar() {
    return solarMode;
  }

  public void toggleSolar() {
    solarMode = !solarMode;
  }
}

//This is so processing can 'see' javascript. idk if we need it
interface JavaScript {
  //list functions here
  public void hideBar();
  public void showBar();
  public void refreshResults();
  public int[] getDimensions();
}

public void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;public void loadWeb(boolean isWeb) {
  if (isWeb) {
    earthImg=loadImage("img/world32k.jpg");
    moonImg=loadImage("img/moon.jpg");
    marsImg=loadImage("img/marsmap2k.jpg");
    mwgImg=loadImage("img/mwg.png");
    bg=loadImage("img/starscape.jpg");
    int[] dimensions = javascript.getDimensions();
    screenWidth = dimensions[0];
    screenHeight = dimensions[1];
    //bg.resize(800,600);
  } else {
    frame.setTitle("Visualizing Our Imaginative Universe - Haley Hiers, Kali Rupert, & Jordan Silver");
    earthImg=loadImage("world32k.jpg");
    moonImg=loadImage("moon.jpg");
    marsImg=loadImage("marsmap2k.jpg");
    mwgImg=loadImage("mwg.png");
    bg=loadImage("starscape.jpg");
    screenWidth = displayWidth;
    screenHeight = displayHeight;
    bg.resize(screenWidth, screenHeight);
    nodeHandler.parseTable("pre1969.csv");
    nodeHandler.parseTable("post1969.csv");
    nodeHandler.parseTable("post1990.csv");
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SciFiVis" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

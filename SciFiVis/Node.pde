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
  boolean inSolarSystem = true;
  boolean fictionalLocation = false;

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
        inSolarSystem = false;
      }
      if (tags[i] == 10) {
        fictionalLocation = true;
      }
    }
    if (inSolarSystem) {
      distance = 200 + random(950);
    } else {
      distance = 1300+ random(1000);
    }
    angle = random(360);
  }

  Node (String novelSet) {
    novel = novelSet; 
    distance = 200 + random(1000);
    angle = random(360);
  }

  void draw() {
    if (!earthNode && !moonNode && !marsNode) {
      noStroke();
      if (inSolarSystem)
        fill(255);
      else
        fill(120);
      rotateY(radians(angle));

      translate(distance, 0, 0);
      sphere(25);

      rotateY(radians(360-angle));
      translate(-40, -60, 40);
      fill(255);
      textFont(font, 32);
      text(novel, 0, 0);
    } else {
      //if earth,moon,mars is being hovered, draw....
    }
  }

  String getNovel() {
    return novel;
  }

  boolean contains(String search) {
    if (novel.toLowerCase().indexOf(search.toLowerCase()) != -1 || author.toLowerCase().indexOf(search.toLowerCase()) != -1) {
      return true;
    } else {
      return false;
    }
  }

  boolean isEarthNode() {
    return earthNode;
  }

  boolean isMoonNode() {
    return moonNode;
  }

  boolean isMarsNode() {
    return marsNode;
  }
  
  boolean isInsideSS() {
     return inSolarSystem; 
  }
  
  boolean isOutsideSS() {
     return !inSolarSystem; 
  }
  
  boolean isFictionalLocation() {
     return fictionalLocation; 
  }
}


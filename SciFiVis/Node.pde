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

  void draw() {
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
    return outsideSolarSystem;
  }

  boolean isOutsideMWG() {
    return outsideMWG;
  }

  boolean isFictionalLocation() {
    return fictionalLocation;
  }

  boolean getGender() {
    return gender;
  }

  boolean isPastWork() {
    return dateWork1;
  }

  boolean isContemporaryWork() {
    return dateWork2;
  }

  boolean isNearFutureWork() {
    return dateWork3;
  }

  boolean isDistantFutureWork() {
    return dateWork4;
  }

  boolean isNAWork() {
    return dateWork5;
  }

  boolean isPastUser() {
    return dateUser1;
  }

  boolean isPresentUser() {
    return dateUser2;
  }

  boolean isFutureUser() {
    return dateUser3;
  }

  String getInfo() {
    String returnString = novel + " (" + published + ")<br>  " + author;
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

  boolean intersect(Node node) {
    if (abs(this.angle - node.angle) < 25) {
      if (abs(this.distance - node.distance) < 250) {
        return true;
      } else return false;
    } else return false;
  }
}


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
    distance = 200 + random(1000);
    angle = random(360);
    for(int i=0;i<tags.length;i++) {
       if(tags[i] == 1) {
          earthNode = true;  
       }
    }
  }

  Node (String novelSet) {
    novel = novelSet; 
    distance = 200 + random(1000);
    angle = random(360);
  }

  void draw() {
    if(!earthNode) {
      noStroke();
      fill(255);
      rotateY(radians(angle));
  
      translate(distance, 0, 0);
      sphere(25);
  
      //rotateX(180);
      rotateY(radians(360-angle));
      translate(-40, -60, 40);
      stroke(255);
      textFont(defaultFont);
      text(novel, 0, 0);
    }
    else {
       //if earth is being hovered, draw.... 
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
}


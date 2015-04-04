class Node {

  float distance;
  float angle;

  PFont font = loadFont("largeFont.vlw");

  String novel;
  String author;
  int published;
  String dateOfAction;
  String locationOfAction;


  Node() {
    distance = 450;
    angle = random(360);
  }

  Node(String novelSet, String authorSet, int publishedSet, String dateOfActionSet, String locationOfActionSet) {
    novel = novelSet;
    author = authorSet;
    published = publishedSet;
    dateOfAction = dateOfActionSet;
    locationOfAction = locationOfActionSet;
    distance = 200 + random(1000);
    angle = random(360);
  }

  Node (String novelSet) {
    novel = novelSet; 
    distance = 200 + random(1000);
    angle = random(360);
  }

  void draw() {
    noStroke();
    fill(255);
    rotateY(radians(angle));

    translate(distance, 0, 0);
    sphere(25);

    //rotateX(180);
    rotateY(radians(360-angle));
    translate(-40, -60, 40);
    stroke(255);
    textFont(font);
    text(novel, 0, 0);
  }

  String getNovel() {
    return novel;
  }
}


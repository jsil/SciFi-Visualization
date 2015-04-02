class Node {

  String bookName;
  float distance;

  float angle;
  
  PFont font = loadFont("largeFont.vlw");


  Node() {
    distance = 450;
    angle = random(360);
  }

  Node(String bookNameSet, float distanceSet, float angleSet) {
    bookName = bookNameSet;
    distance = distanceSet;
    angle = angleSet;
  }

  void draw() {
    noStroke();
    fill(255);
    rotateY(radians(angle));

    translate(distance, 0, 0);
    sphere(25);
    
    //rotateX(180);
    rotateY(radians(360-angle));
    translate(-40,-60,40);
    stroke(255);
    textFont(font);
    text(bookName,0,0);
  }
}


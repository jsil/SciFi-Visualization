class Node {

  String bookName;
  float distance;

  float angle;


  Node() {
    distance = 450;
    angle = random(360);
  }

  Node(float distanceSet, float angleSet) {
    distance = distanceSet;
    angle = angleSet;
  }

  void draw() {
    noStroke();
    fill(255);
    rotateY(radians(angle));

    translate(distance, 0, 0);
    sphere(25);
  }
}


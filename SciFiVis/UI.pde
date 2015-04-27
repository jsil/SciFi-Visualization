class UI {

  PFont font;

  UI() {
    font = createFont("Facet", 24);
  }

  void draw() {
    pushMatrix();

    textFont(font);
    fill(255);
    text("Science Fiction Novel Visualization", 10, 30);

    translate(0,30,0);
    textFont(font,18);
    for (String stat : nodeHandler.getStatistics ()) {
      translate(0, 20, 0);
      text(stat, 10, 0);
    }

    popMatrix();
  }
}


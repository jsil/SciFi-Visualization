class UI {

  PFont font;
  boolean showStats = true;
  boolean showControls = true;

  color textColor = color(255);
  color bgColor = color(145);

  UI() {
    font = createFont("Facet", 24);
  }

  void draw() {
    pushMatrix();
    stroke(textColor);
    fill(bgColor);
    rect(-1, 0, width+1, 30);
    textFont(font, 20);
    fill(255);
    text("Science Fiction Novel Visualization", 10, 20);
    line(400, 0, 400, 30);
    line(550, 0, 550, 30);
    line(700, 0, 700, 30);
    text("Info [+]", 710, 20);
    if (showStats) {
      textFont(font, 20);
      text("Statistics [-]", 410, 20);
      pushMatrix();
      if (!web) {
        if (!showControls) {
          translate(width-300, 30, 0);
        } else {
          translate(width-600, 30, 0);
        }
      } else {
        translate(width-500, 30, 0);
      }
      fill(bgColor);
      rect(0, 0, 300, 150);
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
      text("Statistics [+]", 410, 20);
    }
    if (showControls) {
      textFont(font, 20);
      text("Controls [-]", 560, 20);
      pushMatrix();
      if (!web) {
        translate(width-300, 30, 0);
      } else {
        translate(width-500, 30, 0);
      }
      fill(bgColor);
      rect(0, 0, 300, 100);
      fill(textColor);
      textFont(font, 16);
      translate(8, 18, 0);
      text("Arrow Keys (Mouse Drag) : Pan", 0, 0);
      text("Mouse Wheel : Zoom", 0, 15);
      text("Filter by Published Date : 1, 2, 3", 0, 30);
      text("Show/Hide Statistics : S", 0, 45);
      text("Show/Hide Controls : C", 0, 60);
      popMatrix();
    } else {
      textFont(font, 20);
      text("Controls [+]", 560, 20);
    }
    popMatrix();
  }

  void toggleStats() {
    showStats = !showStats;
  }

  void toggleControls() {
    showControls = !showControls;
  }
}


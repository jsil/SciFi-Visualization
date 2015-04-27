class UI {

  PFont font;
  boolean showStats = true;
  boolean showControls = true;

  UI() {
    font = createFont("Facet", 24);
  }

  void draw() {
    pushMatrix();
    textFont(font,20);
    fill(255);
    text("Science Fiction Novel Visualization", 10, 30);
    if(showStats) {
      pushMatrix();
      translate(0,50,0);
      textFont(font,18);
      for (String stat : nodeHandler.getStatistics ()) {
        translate(0, 20, 0);
        text(stat, 10, 0);
      }
      popMatrix();
    }
    if(showControls) {
      pushMatrix();
      translate(width/2.4,20,0);
      textFont(font,14);
      text("Arrow Keys (Mouse Drag) : Pan Camera",0,0);
      text("Mouse Wheel : Zoom",0,15);
      text("Apply Filter by Published Date : 1 (Pre-1969), 2 (1969-1990), 3 (Post-1990)", 0, 30);
      text("Show/Hide Statistics : S", 0, 45);
      text("Show/Hide Controls : C", 0, 60);
      popMatrix();
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


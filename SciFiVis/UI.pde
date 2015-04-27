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
    
    popMatrix();
  }
}


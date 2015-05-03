class UI {

  PFont font;
  boolean showStats = true;
  boolean showControls = true;
  boolean showFilters = true;
  boolean showInfo = true;


  color textColor = color(255);
  color bgColor = color(145);

  UI() {
    font = createFont("Facet", 24);
  }

  void draw() {
    pushMatrix();
    stroke(textColor);
    if (!web)
      fill(bgColor);
    else 
      noFill();
    rect(-1, 0, width+1, 30);
    textFont(font, 20);
    fill(255);
    text("Visualizing our Imaginative Universe", 10, 20);
    line(400, 0, 400, 30);
    line(550, 0, 550, 30);
    line(700, 0, 700, 30);
    if (showStats) {
      textFont(font, 20);
      text("Statistics [-]", 410, 20);
      pushMatrix();
      if (!web) {
        if (!showControls) {
          if (!showFilters) {
            translate(width-300, 30, 0);
          } else {
            translate(width-600, 30, 0);
          }
        } else {
          if (!showFilters) {
            translate(width-600, 30, 0);
          } else {
            translate(width-900, 30, 0);
          }
        }
      } else {
        translate(width-500, 30, 0);
      }
      if (!web)
        fill(bgColor);
      else 
        noFill();
      rect(0, 0, 300, 280);
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
        if (!showFilters) {
          translate(width-300, 30, 0);
        } else {
          translate(width-600, 30, 0);
        }
      } else {
        translate(width-500, 30, 0);
      }
      if (!web)
        fill(bgColor);
      else 
        noFill();
      rect(0, 0, 300, 100);
      fill(textColor);
      textFont(font, 16);
      translate(8, 18, 0);
      text("Arrow Keys (Mouse Drag) : Pan", 0, 0);
      text("Mouse Wheel : Zoom", 0, 15);
      text("Show/Hide Statistics : S", 0, 30);
      text("Show/Hide Controls : C", 0, 45);
      popMatrix();
    } else {
      textFont(font, 20);
      text("Controls [+]", 560, 20);
    }
    if (showFilters) {
      textFont(font, 20);
      text("Filters [-]", 710, 20);
      pushMatrix();
      if (!web) {
        translate(width-300, 30, 0);
      } else {
        translate(width-500, 30, 0);
      }
      if (!web)
        fill(bgColor);
      else 
        noFill();
      rect(0, 0, 300, 100);
      fill(textColor);
      textFont(font, 16);
      translate(8, 18, 0);
      text("Filter by Published Date : 4, 5, 6", 0, 0);
      text("Filter by Time Relative to Work : P, T, F, D, A", 0, 15); //past, contemporary, near future, distant future, not applicable
      text("Filter by Time Relative to User : E, N, L", 0, 30); //early, now, later
      popMatrix();
    } else {
      textFont(font, 20);
      text("Filters [+]", 710, 20);
    }
    if (showInfo) {
      text("Info [+]", 860, 20);
      pushMatrix();

      popMatrix();
    } else {
      text("Info [-]", 860, 20);
    }
    popMatrix();
  }

  void toggleStats() {
    showStats = !showStats;
  }

  void toggleControls() {
    showControls = !showControls;
  }

  void toggleFilters() {
    showFilters = !showFilters;
  }

  void toggleInfo() {
    showInfo = !showInfo;
  }
}


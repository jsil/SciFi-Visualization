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
    drawFilterBox();
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

  void drawFilterBox() {
    pushMatrix(); 
    translate(10, 50, 0);
    fill(bgColor);
    rect(0, 0, 400, 150);
    fill(textColor);
    textFont(font, 12);
    text("Published", 8, 18);
    for (int i=0; i<3; i++) {
      float x = 10;
      float y = 25 + 25*i;
      float l = 15;
      stroke(0);
      rect(x, y, l, l);
      if (nodeHandler.getPublished(i)) {
        line(x, y, x+l, y+l);
        line(x+l, y, x, y+l);
      }
      if (i == 0) {
        text("Pre-1969", x+l+10, y+10);
      } else if (i == 1) {
        text("1969-1990", x+l+10, y+10);
      } else if (i == 2) {
        text("Post-1990", x+l+10, y+10);
      }
    }

    text("DateOfActionWork", 108, 18);
    for (int i=0; i<5; i++) {
      float x = 110;
      float y = 25 + 25*i;
      float l = 15;
      stroke(0);
      rect(x, y, l, l);
      if (nodeHandler.getDateOfActionWork(i)) {
        line(x, y, x+l, y+l);
        line(x+l, y, x, y+l);
      }
      if (i == 0) {
        text("Past", x+l+10, y+10);
      } else if (i == 1) {
        text("Contemporary", x+l+10, y+10);
      } else if (i == 2) {
        text("Near Future", x+l+10, y+10);
      } else if (i == 3) {
        text("Distant Future", x+l+10, y+10);
      } else if (i == 4) {
        text("N/A", x+l+10, y+10);
      }
    }

    text("DateOfActionUser", 228, 18);
    for (int i=0; i<3; i++) {
      float x = 230;
      float y = 25 + 25*i;
      float l = 15;
      stroke(0);
      rect(x, y, l, l);
      if (nodeHandler.getDateOfActionUser(i)) {
        line(x, y, x+l, y+l);
        line(x+l, y, x, y+l);
      }
      if (i == 0) {
        text("20th Century & Before", x+l+10, y+10);
      } else if (i == 1) {
        text("21st Century", x+l+10, y+10);
      } else if (i == 2) {
        text("22nd Century & Beyond", x+l+10, y+10);
      }
    }
    popMatrix();
  }

  boolean clickFilters(float x, float y) {
    println("x: " + x +  " y: " + y);
    if (x >= 20 && x <= 35) {
      println("1");
      if (y >= 75 && y <= 90) {
        nodeHandler.togglePublished(0);
        return true;
      } else if (y >= 100 && y <= 115) {
        nodeHandler.togglePublished(1);
        return true;
      } else if (y >= 125 && y <= 140) {
        nodeHandler.togglePublished(2);
        return true;
      } else {
        return false;
      }
    } else if (x >= 120 && x <= 135) {
      println("2");
      if (y >= 75 && y <= 90) {
        nodeHandler.toggleDateofActionWork(0);
        return true;
      } else if (y >= 100 && y <= 115) {
        nodeHandler.toggleDateofActionWork(1);
        return true;
      } else if (y >= 125 && y <= 140) {
        nodeHandler.toggleDateofActionWork(2);
        return true;
      } else if (y >= 150 && y <= 165) {
        nodeHandler.toggleDateofActionWork(3);
        return true;
      } else if (y >= 175 && y <= 190) {
        nodeHandler.toggleDateofActionWork(4);
        return true;
      } else {
        return false;
      }
    } else if (x >= 240 && x <= 255) {
      println("3");
      if (y >= 75 && y <= 90) {
        nodeHandler. toggleDateofActionUser(0);
        return true;
      } else if (y >= 100 && y <= 115) {
        nodeHandler. toggleDateofActionUser(1);
        return true;
      } else if (y >= 125 && y <= 140) {
        nodeHandler. toggleDateofActionUser(2);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
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


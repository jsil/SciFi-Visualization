class UI {

  PFont font;
  boolean showStats = true;
  boolean showControls = true;
  boolean showFilters = true;
  boolean showInfo = true;

  boolean solarMode = true;


  color textColor = color(255);
  color bgColor = color(90, 90, 90);

  UI() {
    font = createFont("Facet", 24);
  }

  void draw() {
    float webSpace;
    if (!web) {
      webSpace = 20;
    } else {
      webSpace = 12;
    }
    pushMatrix();
    stroke(textColor);
        if (!web) {
          fill(bgColor);
          rect(-1, 0, width+1, 30);
        } else {
//          translate(0, 0, 30);
          noFill();
          rect(-1, 0, width+1, 30);
//          translate(0,0,5);
        }
    textFont(font, 20);
    fill(255);
    //text("Visualizing our Imaginative Universe", 10, 20);
    line(300, 0, 300, 30);
    line(700, 0, 700, 30);
    line(1000, 0, 1000, 30);
    //line(850, 0, 850, 30);
    if (showStats) {
      textFont(font, 20);
      text("Statistics [-]", 10, webSpace);
      pushMatrix();
      translate(0, 30, 0);

      fill(bgColor);
      rect(0, 0, 300, 280);
      if (!web) {
      } else {
        translate(5, 0, 15);
      }
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
      text("Statistics [+]", 10, webSpace);
    }
    if (showFilters) {
      textFont(font, 20);
      text("Filters [-]", 310, webSpace);
      pushMatrix();
      /*if (!showStats) {
       translate(-300, 0, 0);
       } else {
       translate(0, 0, 0);
       }*/


      drawFilterBox();
      popMatrix();
    } else {
      textFont(font, 20);
      text("Filters [+]", 310, webSpace);
    }
    if (showControls) {
      textFont(font, 20);
      text("Controls [-]", 710, webSpace);
      pushMatrix();
      translate(0, 30, 0);
      /*if (!showStats) {
       if (!showFilters) {
       translate(-700, 0, 0);
       } else {
       translate(-400, 0, 0);
       }
       } else {
       translate(0, 0, 0);
       }*/

      stroke(textColor);
      fill(bgColor);
      rect(700, 0, 300, 100);
      if (!web) {
      } else {
        translate(5, 0, 15);
      }

      fill(textColor);
      textFont(font, 16);
      translate(0, 18, 0);
      text("Arrow Keys (Mouse Drag) : Pan", 708, 0);
      text("Mouse Wheel : Zoom", 708, 15);
      text("Show/Hide Statistics : S", 708, 30);
      text("Show/Hide Controls : C", 708, 45);
      text("Show/Hide Filters : F", 708, 60);
      popMatrix();
    } else {
      textFont(font, 20);
      text("Controls [+]", 710, webSpace);
    }
    if (showInfo) {
      textFont(font, 20);
      text("Info [-]", 1010, webSpace);
      pushMatrix();
      translate(0, 8, 16);
      noStroke();
      fill(bgColor);
      rect(0, 31, width, height);
      if (!web) {
      } else {
        translate(0, 0, 25);
      }

      tint(255);

      fill(textColor);
      translate(0, 31, 0);

      textAlign(CENTER);
      textFont(font, 36);
      text("Visualizing Our Imaginative Universe", (width/2), 90);
      textFont(font, 20);
      text("Created by Haley Hiers, Kali Ruppert, & Jordan Silver", width/2, 180);

      text("    Hugo and Nebula award-winning novels have been analyzed to reveal several\ncrucial pieces of information:  date of publication, date of action, and place of action.  In\ncapturing and visualizing this data, we can reveal how the literary imagination shapes the\nuniverse in three time periods.  Before the Moon Landing (1969), in the period following\nthe moon landing and preceding the launching of the Hubble telescope (1969-1989),\nand after the launching of the Hubble to the present day, looking at where (and when)\nfictional representations situate humanity generates valuable insight into the hopes\nand fears of English-speaking society about the future of our world.", width/2, 240);

      text("Press any key to close", width/2, 560);

      textAlign(LEFT);

      popMatrix();
    } else {
      textFont(font, 20);
      text("Info [+]", 1010, webSpace);
    }
    popMatrix();
  }

  void drawFilterBox() {
    pushMatrix(); 
    translate(300, 30, 0);
    fill(bgColor);
    rect(0, 0, 400, 150);
    if (!web) {
    } else {
      translate(5, 0, 15);
    }
    fill(textColor);
    textFont(font, 13);
    text("Published", 8, 18);
    for (int i=0; i<3; i++) {
      float x = 10;
      float y = 25 + 25*i;
      float l = 15;
      stroke(0);
      fill(255);
      rect(x, y, l, l);
      if (nodeHandler.getPublished(i)) {
        line(x, y, x+l, y+l);
        line(x+l, y, x, y+l);
      }
      fill(255);
      if (i == 0) {
        text("Pre-1969", x+l+5, y+10);
      } else if (i == 1) {
        text("1969-1990", x+l+5, y+10);
      } else if (i == 2) {
        text("Post-1990", x+l+5, y+10);
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
        text("Past", x+l+5, y+10);
      } else if (i == 1) {
        text("Contemporary", x+l+5, y+10);
      } else if (i == 2) {
        text("Near Future", x+l+5, y+10);
      } else if (i == 3) {
        text("Distant Future", x+l+5, y+10);
      } else if (i == 4) {
        text("N/A", x+l+5, y+10);
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
        text("20th Century & Before", x+l+5, y+10);
      } else if (i == 1) {
        text("21st Century", x+l+5, y+10);
      } else if (i == 2) {
        text("22nd Century & Beyond", x+l+5, y+10);
      }
    }
    popMatrix();
  }

  boolean clickFilters(float x, float y) {
    if (x >= 310 && x <= 325) {
      if (y >= 58 && y <= 73) {
        nodeHandler.togglePublished(0);
        return true;
      } else if (y >= 83 && y <= 98) {
        nodeHandler.togglePublished(1);
        return true;
      } else if (y >= 108 && y <= 123) {
        nodeHandler.togglePublished(2);
        return true;
      } else {
        return false;
      }
    } else if (x >= 410 && x <= 425) {
      if (y >= 58 && y <= 73) {
        nodeHandler.toggleDateofActionWork(0);
        return true;
      } else if (y >= 83 && y <= 98) {
        nodeHandler.toggleDateofActionWork(1);
        return true;
      } else if (y >= 108 && y <= 123) {
        nodeHandler.toggleDateofActionWork(2);
        return true;
      } else if (y >= 133 && y <= 148) {
        nodeHandler.toggleDateofActionWork(3);
        return true;
      } else if (y >= 158 && y <= 173) {
        nodeHandler.toggleDateofActionWork(4);
        return true;
      } else {
        return false;
      }
    } else if (x >= 530 && x <= 545) {
      if (y >= 58 && y <= 73) {
        nodeHandler. toggleDateofActionUser(0);
        return true;
      } else if (y >= 83 && y <= 98) {
        nodeHandler. toggleDateofActionUser(1);
        return true;
      } else if (y >= 108 && y <= 123) {
        nodeHandler. toggleDateofActionUser(2);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  boolean clickToggles(float x, float y) {
    if (y <= 30) {
      if (x <= 300) {
        toggleStats();
        return true;
      } else if (x <= 700) {
        toggleFilters();
        return true;
      } else if (x <= 1000) {
        toggleControls();
        return true;
      } else {
        toggleInfo();
        return true;
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

  boolean getShowInfo() {
    return showInfo;
  }

  boolean isSolar() {
    return solarMode;
  }

  void toggleSolar() {
    solarMode = !solarMode;
  }
}


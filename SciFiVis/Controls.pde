float dragX;
float dragY;

float panX = 0;
float panY = 0;
float zoom = 0;

void keyPressed() {
  if (keyCode == LEFT) {
    panX = panX + 35;
  } else if (keyCode == RIGHT) {
    panX = panX - 35;
  }
  if (keyCode == UP) {
    panY = panY + 35;
  } else if (keyCode == DOWN) {
    panY = panY - 35;
  }
  if(key == '1') {
     nodeHandler.togglePublished(0); 
     earth.countNodes();
     moon.countNodes();
     mars.countNodes();
  }
  if(key == '2') {
     nodeHandler.togglePublished(1); 
     earth.countNodes();
     moon.countNodes();
     mars.countNodes();
  }
  if(key == '3') {
     nodeHandler.togglePublished(2); 
     earth.countNodes();
     moon.countNodes();
     mars.countNodes();
  }
  if(key == 's') {
     ui.toggleStats(); 
  }
  if(key == 'c') {
     ui.toggleControls(); 
  }
  if(key == 'i') {
     ui.toggleInfo(); 
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom += 3.5*e;
  if (zoom > 1500)
    zoom = 1500;
  else if (zoom < -2500)
    zoom = -2500;
}

void mousePressed() {
  dragY = mouseY;
  dragX = mouseY;
}

void mouseDragged() {
  panY = panY + (mouseY - dragY);
  if(mouseY > dragY) {
     panY = panY + (mouseY - dragY);
    dragY = mouseY; 
  }
  else {
    panY = panY - (dragY - mouseY);
    dragY = mouseY;
  }
  if (mouseX > dragX) {
    panX = panX + (mouseX - dragX);
    dragX = mouseX;
  } else {
    panX = panX - (dragX - mouseX);
    dragX = mouseX;
  }
}


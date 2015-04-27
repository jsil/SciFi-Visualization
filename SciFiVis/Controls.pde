void keyPressed() {
  //todo: smooth key controls
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
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom += 3.5*e;
  if (zoom > 1500)
    zoom = 1500;
  else if (zoom < -2500)
    zoom = -2500;
  println("zoom: " + zoom);
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


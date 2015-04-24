
// Use arrow keys to change detail settings
void keyPressed() {
  //todo: smooth key controls
  if (keyCode == RIGHT) {
    panX = panX + 35;
  } else if (keyCode == LEFT) {
    panX = panX - 35;
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
  if (mouseX > dragX) {
    panX = panX + (mouseX - dragX);
    dragX = mouseX;
  } else {
    panX = panX - (dragX - mouseX);
    dragX = mouseX;
  }
}


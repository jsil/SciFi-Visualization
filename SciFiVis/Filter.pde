class Filter {
  Node node;
  Filter(Node node) {
    this.node = node;
  }

  void drawEarly() {
    if (published <= 1969) {
      node.draw();
    }
  }

  void drawMiddle() {
    if ((published > 1969) & (published <= 1989) {
      node.draw();
    }
  }

  void drawLate() {
    if (published > 1989) {
      node.draw();
    }
  }
}


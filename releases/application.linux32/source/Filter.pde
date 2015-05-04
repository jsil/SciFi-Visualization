class Filter {

  Filter() {
  }
  //publication date
  int filterPublished(Node node) {
    if (node.published <= 1969) {
      return 0;
    } else if ((node.published > 1969) & (node.published <= 1990)) {
      return 1;
    } else {
      return 2;
    }
  }
  //Time categories relevant to the work itself
  boolean filterPastWork(Node node) {
    if (node.isPastWork()) {
      return true;
    }
    else
      return false;
  }

  //Time categories relevant to the user
//  int filterTimeForUser(Node node) {
//    if (node.tags[12] == 40) {
//      return 40;
//    } else if (node.tags[13] == 41) {
//      return 41;
//    } else if (node.tags[14] == 42) {
//      return 42;
//    }
//  }
}


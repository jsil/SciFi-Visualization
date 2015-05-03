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
  int filterTimeForWork(Node node) {
    if (node.tags[7] == 30) {
      return 30;
    } else if (node.tags[8] == 31) {
      return 31;
    } else if (node.tags[9] == 32) {
      return 32;
    }else if (node.tags[10] == 33) {
      return 33; 
    }else if (node.tags[11] == 34) {
      return 34;
    }
  }

  //Time categories relevant to the user
  int filterTimeForUser(Node node) {
    if (node.tags[12] == 40) {
      return 40;
    } else if (node.tags[13] == 41) {
      return 41;
    } else if (node.tags[14] == 42) {
      return 42;
    }
  }
}


class Filter {

  Filter() {
  }

int filterPublished(Node node) {
    if (node.published <= 1969) {
      return 1;
    } else if ((node.published > 1969) & (node.published <= 1990)) {
      return 2;
    } else {
      return 3;
    }
  }

}


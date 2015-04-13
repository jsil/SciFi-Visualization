class Filter {

  Filter() {
  }

  void filterPublished(Node node) {
    if (published <= 1969) {
      return 1;
    } else if ((published > 1969) & (published <= 1990)) {
      return 2;
    } else {
      return 3;
    }
  }

}


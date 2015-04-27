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
  String filterTimeForWork(Node node) {
    if (node.dateOfActionWork == "Contemporary") {
      return "C";
    } else if (node.dateOfActionWork == "Near Future") {
      return "NF";
    } else if (node.dateOfActionWork == "Distant Future") {
      return "DF";
    } else {
      return "VDF";
    }
  }

  //Time categories relevant to the user
  String filterTimeForUser(Node node) {
    if (node.dateOfActionUser == "20th Century") {
      return "20C";
    } else if (node.dateOfActionUser == "Present") {
      return "P";
    } else if (node.dateOfActionUser == "22nd Century and Beyond") {
      return "22C";
    } else {
      return "BNM"; 
    }
  }
}


class Sizes {
  static double width = 200;
  static double height = 400;

  static double padding = 10;
  static double border = padding / 2;
  static double boxSeparation = padding / 2;
  static double font2 = 30;
  static double font4 = 24;
  static double font6 = 22;
  static double font8 = 20;
  static double font10 = 16;
  static double font11 = 14;
  static double font12 = 12;

  static double tileHeightExpandedCard = 0;
  static double tileHeightHugePlus = 0;
  static double tileHeightHuge = 0;
  static double tileHeightCard = 0;
  static double tileHeightBig = 0;
  static double tileHeightLarge = 0;
  static double tileHeightMedium = 0;
  static double tileHeightChip = 0;
  static double tileHeightSmall = 0;
  static double tileHeightMicro = 0;

  static double halfCardSize = (width - 2 * padding - boxSeparation) / 2;

  static void setSizes(double newWidth, double newHeight) {
    width = newWidth;
    height = newHeight;

    padding = newWidth / 20;
    boxSeparation = padding / 4;
    border = padding * 0.8;

    font8 = 20;

    halfCardSize = (width - 2 * padding - boxSeparation) / 2;

    double maxSize = (height > width) ? height : width;

    tileHeightExpandedCard = maxSize / 4;
    tileHeightHugePlus = maxSize / 6;
    tileHeightHuge = maxSize / 8;
    tileHeightCard = maxSize / 9;
    tileHeightBig = maxSize / 10;
    tileHeightLarge = maxSize / 12;
    tileHeightMedium = maxSize / 18;
    tileHeightChip = maxSize / 16;
    tileHeightSmall = maxSize / 22;
    tileHeightMicro = maxSize / 40;
  }
}

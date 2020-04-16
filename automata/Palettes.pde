public class SalmonColorPalette extends ColorPalette {

  public SalmonColorPalette() {
    super(
      new color[]{
      color(74, 39, 37), 
      color(214, 112, 107), 
      color(138, 72, 69), 
      color(150, 79, 75), 
      color(112, 59, 56)});
  }
}


public class VioletteColorPalette extends ColorPalette {

  public VioletteColorPalette() {
    super(
      new color[]{
      color(70, 36, 79), 
      color(195, 99, 219), 
      color(128, 65, 143), 
      color(138, 70, 156), 
      color(104, 53, 117)});
  }
}

public class GreyColorPalette extends ColorPalette {

  public GreyColorPalette() {
    super(
      new color[]{
      color(188, 191, 184), 
      color(126, 128, 122), 
      color(251, 255, 244), 
      color(63, 64, 61), 
      color(226, 230, 220)});
  }
}

public ColorPalette getRandomColorPalette() {
  int randomPaletteIndicator = (int)random(1, 4);
  if (randomPaletteIndicator == 1) {
    return new SalmonColorPalette();
  }
  if (randomPaletteIndicator == 2) {
    return new VioletteColorPalette();
  }
  return new GreyColorPalette();
}

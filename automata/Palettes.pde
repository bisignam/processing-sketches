public class SalmonColorPalette extends ColorPalette {

  public SalmonColorPalette() {
    super(
      Arrays.asList(
      new Color(74, 39, 37), 
      new Color(214, 112, 107), 
      new Color(138, 72, 69), 
      new Color(150, 79, 75), 
      new Color(112, 59, 56))); 
  }
}


public class VioletteColorPalette extends ColorPalette {

  public VioletteColorPalette() {
    super(
      Arrays.asList(
      new Color(70, 36, 79), 
      new Color(195, 99, 219), 
      new Color(128, 65, 143), 
      new Color(138, 70, 156), 
      new Color(104, 53, 117)));
  }
}


public class GreyColorPalette extends ColorPalette {

  public GreyColorPalette() {
    super(
      Arrays.asList(
      new Color(188, 191, 184), 
      new Color(126, 128, 122), 
      new Color(251, 255, 244), 
      new Color(63, 64, 61), 
      new Color(226, 230, 220)));
  }
}

public ColorPalette getRandomColorPalette(){
  int randomPaletteIndicator = (int)random(1, 4);
  if(randomPaletteIndicator == 1){
    return new SalmonColorPalette();
  }
  if(randomPaletteIndicator == 2){
    return new VioletteColorPalette();
  }
  return new GreyColorPalette();
}

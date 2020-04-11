import java.util.List;

class ColorPalette {

  private final List<Color> colors;
  private int currentIndex = 0;

  ColorPalette(List<Color> colors) {
    this.colors = colors;
  }
  
  public Color currentColor(){
    return colors.get(currentIndex);   
  }

  public Color nextColor(){
    if(currentIndex+1 >= colors.size()) {
      reset();
      return currentColor();
    }
    currentIndex++;
    return colors.get(currentIndex); 
  }
  
  public Color getRandomColor(){
    return colors.get((int)random(0, colors.size()-1)); 
  }
  
  public void reset() {
    this.currentIndex = 0;
  }
}

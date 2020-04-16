import java.util.List;

class ColorPalette {

  private final color[] colors;
  private int currentIndex = 0;

  ColorPalette(color[] colors) {
    this.colors = colors;
  }
  
  public color currentColor(){
    return colors[currentIndex];   
  }

  public color nextColor(){
    if(currentIndex+1 >= colors.length) {
      reset();
      return currentColor();
    }
    currentIndex++;
    return currentColor(); 
  }
  
  public color getRandomColor(){
    return colors[(int)random(0, /**not included**/colors.length)]; 
  }
  
  public void reset() {
    this.currentIndex = 0;
  }
}

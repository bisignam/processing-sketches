public class Color {
  private float red;
  private float green;
  private float blue;
  private float alpha;

  public Color(float red, float green, float blue) {
    this.red = red;
    this.green = green;
    this.blue = blue;
    this.alpha = 100;
  }

  public Color(float red, float green, float blue, float alpha) {
    this.red = red;
    this.green = green;
    this.blue = blue;
    this.alpha = alpha;
  }

  public float getRed() {
    return this.red;
  }

  public float getGreen() {
    return this.green;
  }

  public float getBlue() {
    return this.blue;
  }
  
  public float getAlpha(){
   return this.alpha; 
  }
}

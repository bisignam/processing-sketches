public class Pixel {

  private int x;
  private int y;
  private color c = color(255, 255, 255, 255);
  private color originalColor = color(255, 255, 255, 255);

  Pixel(Pixel toCopy) {
    this.x = toCopy.getX();
    this.y = toCopy.getY();
    this.c = toCopy.getColor();
    this.originalColor = toCopy.getOriginalColor();
  }

  Pixel(int x, int y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
    this.originalColor = c;
  }

  Pixel(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public int getX() {
    return this.x;
  }

  public int getY() {
    return this.y;
  }

  public color getColor() {
    return this.c;
  }

  public void setColor(color c) {
    this.c = c;
  }

  public color getOriginalColor() {
    return this.originalColor;
  }
}

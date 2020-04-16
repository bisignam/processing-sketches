public class RandomAnimation extends Animation {

  public void setupAnimation(Pixel pixel) {
    return;
  }
  
  public Pixel outsideWidthBound(Pixel pixel) {
    return pixel;
  }

  public Pixel outsideHeightBound(Pixel pixel) {
    return pixel;
  }

  public List<Pixel> getNextPixelsToAnimate(Pixel pixel, int step) {
    List<Pixel> nextPixelsToAnimate = new LinkedList();
    int randomX1 = pixel.getX() + (int)random(grid.getGridWidth());
    int randomX2 = pixel.getX() + (int)random(grid.getGridWidth());
    int randomY1 = pixel.getY() + (int)random(grid.getGridHeight());
    int randomY2 = pixel.getY() + (int)random(grid.getGridHeight());
    nextPixelsToAnimate.add(
      new Pixel(randomX1 > grid.getGridWidth()-1 ? (int)random(grid.getGridWidth()) : randomX1, pixel.getY()));
    nextPixelsToAnimate.add(
      new Pixel(randomX2 > grid.getGridWidth()-1 ? (int)random(grid.getGridWidth()) : randomX2, pixel.getY()));
    nextPixelsToAnimate.add(
      new Pixel(pixel.getX(), randomY1 > grid.getGridHeight()-1 ? (int)random(grid.getGridHeight()) : randomY1));
    nextPixelsToAnimate.add(
      new Pixel(pixel.getX(), randomY2 > grid.getGridHeight()-1 ? (int)random(grid.getGridHeight()) : randomY2));
    return nextPixelsToAnimate;
  }
}

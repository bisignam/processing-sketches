public class CrossAnimation extends Animation {

  public void setupAnimation(Pixel pixel) {
    return;
  }

  public Pixel outsideWidthBound(Pixel pixel) {
    return null;
  }

  public Pixel outsideHeightBound(Pixel pixel) {
    return null;
  }

  public List<Pixel> getNextPixelsToAnimate(Pixel pixel, int step) {
    List<Pixel> nextPixelsToAnimate = new LinkedList();
    int pixelX = pixel.getX();
    int pixelY = pixel.getY();
    nextPixelsToAnimate.add(new Pixel(pixelX + step, pixelY));
    nextPixelsToAnimate.add(new Pixel(pixelX - step, pixelY));
    nextPixelsToAnimate.add(new Pixel(pixelX, pixelY + step));
    nextPixelsToAnimate.add(new Pixel(pixelX, pixelY - step));
    return nextPixelsToAnimate;
  }
}

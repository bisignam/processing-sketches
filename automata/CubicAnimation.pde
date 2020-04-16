public class CubicAnimation extends Animation {

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

    int pixelX = pixel.getX();
    int pixelY = pixel.getY();

    color animationColor = color(255, 255, 255, 100 - map(step, 0, maxStep, 0, 100));

    List<Pixel> nextPixelsToAnimate = new LinkedList();
    //right down angle
    nextPixelsToAnimate.add(new Pixel(pixelX + step, pixelY + step, animationColor));

    for (int x=0; x<step*2; x++) {
      nextPixelsToAnimate.add(new Pixel(pixelX - step + x, pixelY + step, animationColor));
    }

    //left down angle
    nextPixelsToAnimate.add(new Pixel(pixelX - step, pixelY + step, animationColor));

    for (int y=0; y<step*2; y++) {
      nextPixelsToAnimate.add(new Pixel(pixelX - step, pixelY - step + y, animationColor));
    }

    //left top angle
    nextPixelsToAnimate.add(new Pixel(pixelX - step, pixelY - step, animationColor));

    for (int x=0; x<step*2; x++) {
      nextPixelsToAnimate.add(new Pixel(pixelX - step + x, pixelY - step, animationColor));
    }

    //right top angle
    nextPixelsToAnimate.add(new Pixel(pixelX + step, pixelY - step, animationColor));

    for (int y=0; y<step*2; y++) {
      nextPixelsToAnimate.add(new Pixel(pixelX + step, pixelY - step + y, animationColor));
    }

    return nextPixelsToAnimate;
  }

  public void animate(Pixel pixel) {
    this.grid.setAndDrawPixel(pixel, 255, 1);
  }
}

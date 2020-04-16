public class ExplosionAnimation extends Animation {

  public void setupAnimation(Pixel pixel) {
    return;
  }

  public Pixel outsideWidthBound(Pixel pixel) {
    return null;
  }

  public Pixel outsideHeightBound(Pixel pixel) {
    return null;
  }

  public List<Pixel> getNextPixelsToAnimate(Pixel explosionKernel, int step) {
    List<Pixel> nextPixelsToAnimate = new LinkedList<Pixel>();
    int kernelX = explosionKernel.getX();
    int kernelY = explosionKernel.getY();
    nextPixelsToAnimate.add(new Pixel(kernelX + step, kernelY));
    nextPixelsToAnimate.add(new Pixel(kernelX - step, kernelY));
    nextPixelsToAnimate.add(new Pixel(kernelX, kernelY + step));
    nextPixelsToAnimate.add(new Pixel(kernelX, kernelY - step));
    nextPixelsToAnimate.add(new Pixel(kernelX - step, kernelY - step));
    nextPixelsToAnimate.add(new Pixel(kernelX - step, kernelY + step));
    nextPixelsToAnimate.add(new Pixel(kernelX + step, kernelY - step));
    nextPixelsToAnimate.add(new Pixel(kernelX + step, kernelY + step));
    return nextPixelsToAnimate;
  }
  
  public void animate(Pixel pixel) {
     this.grid.setAndDrawPixel(pixel, 20, 1);
  }
}

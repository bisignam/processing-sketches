public abstract class Animation {

  protected Grid grid;

  //General setup
  public abstract void setupAnimation(Pixel pixel);

  //What to do when a pixel is outside width bound
  public abstract Pixel outsideWidthBound(Pixel pixel);

  //What to do when a pixel is outside height bound
  public abstract Pixel outsideHeightBound(Pixel pixel);

  //Get the next pixels to activate
  public abstract List<Pixel> getNextPixelsToAnimate(Pixel pixel, int step);

  //SuPbclasses should put here actual animation behaviour for a given pixel
  //Default behaviour is to use the grid draw method
  public void animate(Pixel pixel) {
     this.grid.setAndDrawPixel(pixel, 0, 0);
  }

  public void setGrid(Grid grid) {
    this.grid = grid;
  }
}

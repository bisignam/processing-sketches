public abstract class CellularAutomaton {  //<>//

  protected Grid grid;

  public abstract color applyRule(int x, int y);

  public abstract color activationColor();

  public void setGrid(Grid grid) {
    this.grid = grid;
  }

  protected int mooreNeighbors(int x, int y) {
    if (x == 49 && y == 47 && isActive(x, y)) {
      System.out.println("debug");
    }
    int activeNeighbors = 0;
    List<Pixel> neighbors = new LinkedList<Pixel>();
    neighbors.add(xBeyondWidth(new Pixel(x + 1, y)));
    neighbors.add(xLessThanZero(new Pixel(x - 1, y)));
    neighbors.add(yBeyondHeight(new Pixel(x, y + 1)));
    neighbors.add(yLessThanZero(new Pixel(x, y - 1)));
    neighbors.add(xLessThanZero(yLessThanZero(new Pixel(x - 1, y - 1))));
    neighbors.add(xLessThanZero(yBeyondHeight(new Pixel(x - 1, y + 1))));
    neighbors.add(xBeyondWidth(yLessThanZero(new Pixel(x + 1, y - 1))));
    Pixel diagonalCiao = xBeyondWidth(yBeyondHeight(new Pixel(x + 1, y + 1)));
    neighbors.add(diagonalCiao);
    for (Pixel neighbor : neighbors) {
      if (isActive(neighbor.getX(), neighbor.getY())) {
        activeNeighbors++;
      }
    }
    return activeNeighbors;
  }

  protected Pixel yBeyondHeight(Pixel pixel) {
    if (pixel.getY() >  grid.getGridHeight() - 1) {
      return new Pixel(pixel.getX(), (abs(pixel.getY()) % (grid.getGridHeight()- 1) -1 ));
    }
    return pixel;
  }

  protected Pixel yLessThanZero(Pixel pixel) {
    if (pixel.getY() < 0) {
      return new Pixel(pixel.getX(), grid.getGridHeight() - (abs(pixel.getY()) % grid.getGridHeight()));
    }
    return pixel;
  }

  protected Pixel xBeyondWidth(Pixel pixel) {
    if (pixel.getX() >  grid.getGridWidth() - 1) {
      return new Pixel((abs(pixel.getX()) % (grid.getGridWidth()- 1) - 1), pixel.getY());
    }
    return pixel;
  }

  protected Pixel xLessThanZero(Pixel pixel) {
    if (pixel.getX() < 0) {
      return new Pixel(grid.getGridWidth()-(abs(pixel.getX()) % grid.getGridWidth()), pixel.getY());
    }
    return pixel;
  }

  public boolean isActive(int x, int y) {
    color activationColor = activationColor();
    color pixelColor = grid.gridPixels[x][y].getColor(); 
    return activationColor == pixelColor;
  }
}

public class GameOfLife extends CellularAutomaton {

  /** 
   Any live cell with fewer than two live neighbours dies, as if by underpopulation.
   Any live cell with two or three live neighbours lives on to the next generation.
   Any live cell with more than three live neighbours dies, as if by overpopulation.
   Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
   **/
  public color applyRule(int x, int y) {
    if (x==27 && y == 24) {
      System.out.println("debug"); //<>//
    }
     int numberOfActiveNeighbors = getNumberOfActiveNeighbors(x, y);
    if (isActive(x, y) &&  numberOfActiveNeighbors < 2) {
      return grid.gridPixels[x][y].getOriginalColor();
    } else if (isActive(x, y) && numberOfActiveNeighbors > 3) {
      return grid.gridPixels[x][y].getOriginalColor();
    } else if (!isActive(x, y) && numberOfActiveNeighbors == 3) {
      return activationColor();
    }
    return grid.gridPixels[x][y].getColor();
  }

  private int getNumberOfActiveNeighbors(int x, int y) {
    if (x==27 && y == 24) {
      System.out.println("debug"); //<>//
    }
    int activeNeighbors = 0;

    List<Pixel> neighbors = new LinkedList<Pixel>();
    if (x < grid.getGridWidth()-1) {
      neighbors.add(new Pixel(x + 1, y));
    }
    if (x > 0) {
      neighbors.add(new Pixel(x - 1, y));
    }
    if (y < grid.getGridHeight()-1) {
      neighbors.add(new Pixel(x, y + 1));
    }
    if (y > 0) {
      neighbors.add(new Pixel(x, y - 1));
    }
    if (x > 0 && y > 0) {
      neighbors.add(new Pixel(x - 1, y - 1));
    }
    if (x > 0 && y < grid.getGridHeight()-1) {
      neighbors.add(new Pixel(x - 1, y + 1));
    }
    if (x < grid.getGridWidth()-1 && y > 0) {
      neighbors.add(new Pixel(x + 1, y - 1));
    }
    if (x < grid.getGridWidth()-1 && y < grid.getGridHeight()-1) {
      neighbors.add(new Pixel(x + 1, y + 1));
    }

    for (Pixel neighbor : neighbors) {
      if (isActive(neighbor.getX(), neighbor.getY())) {
        activeNeighbors++;
      }
    }

    return activeNeighbors;
  }

  public boolean isActive(int x, int y) {
    color activationColor = activationColor();
    color pixelColor = grid.gridPixels[x][y].getColor(); 
    return activationColor == pixelColor;
  }

  public color activationColor() {
    return color(255, 255, 255, 255);
  }
}

public class GameOfLife extends CellularAutomaton { //<>//

  /** 
   Any live cell with fewer than two live neighbours dies, as if by underpopulation.
   Any live cell with two or three live neighbours lives on to the next generation.
   Any live cell with more than three live neighbours dies, as if by overpopulation.
   Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
   **/
  public color applyRule(int x, int y) {
    int numberOfActiveNeighbors = mooreNeighbors(x, y);
    if (isActive(x, y) &&  numberOfActiveNeighbors < 2) {
      return grid.gridPixels[x][y].getOriginalColor();
    } else if (isActive(x, y) && numberOfActiveNeighbors > 3) {
      return grid.gridPixels[x][y].getOriginalColor();
    } else if (!isActive(x, y) && numberOfActiveNeighbors == 3) {
      return activationColor();
    }
    return grid.gridPixels[x][y].getColor();
  }

  public color activationColor() {
    return color(255, 255, 255, 255);
  }
}

public class Seeds extends CellularAutomaton {

  /** 
   In each time step, a cell turns on or is "born" if it was off or "dead" but 
   had exactly two neighbors that were on; all other cells turn off.
   **/
  public color applyRule(int x, int y) {
    int numberOfActiveNeighbors = mooreNeighbors(x, y);
    if (!isActive(x, y) &&  numberOfActiveNeighbors == 2) {
      return activationColor();
    }
    return grid.gridPixels[x][y].getOriginalColor();
  }

  public color activationColor() {
    return color(255, 255, 255, 255);
  }
}

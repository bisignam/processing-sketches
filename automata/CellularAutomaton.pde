public abstract class CellularAutomaton { 

  protected Grid grid;

  public abstract color applyRule(int x, int y);

  public abstract boolean isActive(int x, int y);

  public abstract color activationColor();

  public void setGrid(Grid grid) {
    this.grid = grid;
  }
}

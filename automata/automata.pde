import java.util.Arrays;
import java.util.Map;
import java.util.LinkedList;

int automataSize = 5;
Grid grid;
int currentStep = 1;
int maxStep = 140;
//int maxStep = 152;
int activationX = 0;
int activationY = 0;
ColorPalette gridColorPalette = new VioletteColorPalette();
//Animation animation = new RandomAnimation();
//Animation animation = new ExplosionAnimation();
//Animation animation = new CubicAnimation();
//Animation animation = new CrossAnimation();
//CellularAutomaton cellularAutomaton = new GameOfLife();
Seeds cellularAutomaton = new Seeds();

public void setup() {
  size(1000, 1000);
  //fullScreen();
  //frameRate(2);
  background(0);
  colorMode(RGB);

  grid = new Grid(automataSize);
}

public void draw() {
  if (currentStep == maxStep) {
    return;
  }
  //grid.reset(color(255, 255, 0), color(0, 255, 0));
      grid.reset(gridColorPalette);

  initializeGridWithActiveCells2();

  if (currentStep == 0 || currentStep == maxStep) {
    activationX = (int)random(grid.getGridWidth()-1);
    activationY = (int)random(grid.getGridHeight()-1);

    grid.reset(gridColorPalette);
    //grid.reset(color(255, 255, 0), color(0, 255, 0));

    //To be used in the case of cellular automaton usage
    initializeGridWithActiveCells2();

    if (currentStep != 0) {
      currentStep = 0;
    }
  }
  grid.applyCellularAutomatonRule(cellularAutomaton, currentStep);
  //grid.drawAnimationStep(animation, activationX, activationY, currentStep);
  currentStep++;
}

public void initializeGridWithActiveCells1() {
  //line
  /** for (int i=25; i<30; i++) {
   grid.activate(cellularAutomaton, i, 25);
   }**/

  //glider
  grid.activate(cellularAutomaton, 10, 10);
  grid.activate(cellularAutomaton, 12, 10);
  grid.activate(cellularAutomaton, 11, 11);
  grid.activate(cellularAutomaton, 12, 11);
  grid.activate(cellularAutomaton, 11, 12);
}

public void initializeGridWithActiveCells2() {
  //line
  /** for (int i=25; i<30; i++) {
   grid.activate(cellularAutomaton, i, 25);
   }**/

  //glider
 // grid.activate(cellularAutomaton, 10, 10);
 // grid.activate(cellularAutomaton, 12, 10);
  grid.activate(cellularAutomaton, 11, 11);
  grid.activate(cellularAutomaton, 12, 11);
  grid.activate(cellularAutomaton, 11, 12);
}

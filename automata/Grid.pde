public class Grid { //<>// //<>//

  private int gridWidth;
  private int gridHeight;
  private int pixelsSize;

  private Pixel[][] gridPixels = new Pixel[][]{};

  Grid(int pixelsSize) {
    this.gridWidth = width/pixelsSize;
    this.gridHeight = height/pixelsSize;
    this.pixelsSize = pixelsSize;
    gridPixels = new Pixel[gridWidth][gridHeight];
  }

  public void reset(ColorPalette colorPalette) {
    for (int i=0; i<gridWidth; i+=1) {
      for (int j=0; j<gridHeight; j+=1) {
        gridPixels[i][j] = new Pixel(i, j, colorPalette.currentColor());
        drawPixel(i, j);
      }
      colorPalette.nextColor();
    }
  }

  public void reset(color from, color to) {
    for (int i=0; i<gridWidth; i+=1) {
      for (int j=0; j<gridHeight; j+=1) {
        gridPixels[i][j] = new Pixel(i, j, lerpColor(from, to, (1.0/(float)(gridWidth*gridHeight))));
        drawPixel(i, j);
      }
    }
  }

  public void setAndDrawPixel(Pixel pixel, float stroke, float strokeWeight) {
    pushMatrix();
    stroke(stroke);
    strokeWeight(strokeWeight);
    gridPixels[pixel.getX()][pixel.getX()] = new Pixel(pixel.getX(), pixel.getY(), pixel.getColor());
    fill(red(pixel.getColor()), 
      green(pixel.getColor()), 
      blue(pixel.getColor()), 
      alpha(pixel.getColor()));
    square(automataSize*pixel.getX(), automataSize*pixel.getY(), automataSize);
    popMatrix();
  }

  private void drawPixel(int x, int y) {
    pushMatrix();
    stroke(0);
    strokeWeight(0);
    color automataColor = gridPixels[x]
      [y].getColor();
    fill(red(automataColor), 
      green(automataColor), 
      blue(automataColor), 
      alpha(automataColor));
    square(automataSize*x, automataSize*y, automataSize);
    popMatrix();
  }

  public void activate(CellularAutomaton cellurarAutomaton, int x, int y) {
    gridPixels[x][y].setColor(cellurarAutomaton.activationColor());
    drawPixel(x, y);
  }

  public void applyCellularAutomatonRule(CellularAutomaton cellurarAutomaton, int stepsToCompute) {
    cellurarAutomaton.setGrid(this);
    Pixel[][] gridPixelsCopy = new Pixel[gridWidth][gridHeight];
    for (int i=0; i<stepsToCompute; i++) {
      gridPixelsCopy = cloneGrid();
      for (int x=0; x<gridWidth; x+=1) {
        for (int y=0; y<gridHeight; y+=1) {
          gridPixelsCopy[x][y].setColor(cellurarAutomaton.applyRule(x, y));
        }
      }
      setGrid(gridPixelsCopy);
    }
    for (int x=0; x<gridWidth; x+=1) {
      for (int y=0; y<gridHeight; y+=1) {
        drawPixel(x, y);
      }
    }
  }

  public void drawAnimationStep(Animation animation, int x, int y, int step) {
    animation.setGrid(this);
    List<Pixel> pixelsToAnimate = animation.getNextPixelsToAnimate(new Pixel(x, y), step);
    for (Pixel pixelToAnimate : pixelsToAnimate) {
      //Manage X boundary
      if (pixelToAnimate.getX() < 0 || pixelToAnimate.getX() > gridWidth-1) {
        pixelToAnimate = animation.outsideWidthBound(pixelToAnimate);
      }
      //Manage Y boundary
      if (pixelToAnimate != null && (pixelToAnimate.getY() < 0 || pixelToAnimate.getY() > gridHeight-1)) {      
        pixelToAnimate = animation.outsideHeightBound(pixelToAnimate);
      }
      if (pixelToAnimate != null) {
        animation.animate(pixelToAnimate);
      }
    }
  }

  public int getGridWidth() {
    return this.gridWidth;
  }

  public int getGridHeight() {
    return this.gridHeight;
  }

  public int getPixelsSize() {
    return this.pixelsSize;
  }

  private Pixel[][] cloneGrid() {
    Pixel[][] clonedGrid = new Pixel[gridWidth][gridHeight];
    for (int x=0; x<gridWidth; x+=1) {
      for (int y=0; y<gridHeight; y+=1) {
        clonedGrid[x][y] = new Pixel(gridPixels[x][y]);
      }
    }
    return clonedGrid;
  }

  private void setGrid(Pixel[][] newGrid) {
    for (int x=0; x<gridWidth; x+=1) {
      for (int y=0; y<gridHeight; y+=1) {
        gridPixels[x][y] = new Pixel(newGrid[x][y]);
      }
    }
  }
}

PImage rock;
PImage paper;
PImage scissor;
PImage fuck;

int squareSize = 20;

void setup() {
  size(1000, 1000);
  //fullScreen();
  frameRate(10);
  rock = loadImage("rock.jpg");
  paper = loadImage("paper.jpg");
  scissor = loadImage("scissor.jpg");
  fuck = loadImage("fuck.jpg");
}

void draw() {

  int pictureToShow = (int)random(1, 5);

  if (pictureToShow == 1) {
    rock.resize(width, height);
    rock.filter(GRAY);
    rock.filter(THRESHOLD, 0.51);
    drawPixelizedImage(rock);
  }
  if (pictureToShow == 2) {
    paper.resize(width, height);
    paper.filter(GRAY);
    paper.filter(THRESHOLD, 0.51);
    drawPixelizedImage(paper);
  }
  if (pictureToShow == 3) {
    scissor.resize(width, height);
    scissor.filter(GRAY);
    scissor.filter(THRESHOLD, 0.51);
    drawPixelizedImage(scissor);
  }
  if (pictureToShow == 4) {
    fuck.resize(width, height);
    fuck.filter(GRAY);
    fuck.filter(THRESHOLD, 0.51);
    drawPixelizedImage(fuck);
  }
}

public void drawPixelizedImage(PImage image) {
  for (int i=0; i<width; i+=squareSize) {
    for (int j=0; j<height; j+=squareSize) {
      pushMatrix();
      color[] colorsForSquare = new color[squareSize*squareSize];
      int colorIndex=0;
      for (int is=i-squareSize/2; is<i+squareSize/2; is++) {
        for (int js=j-squareSize/2; js<j+squareSize/2; js++) {
          colorsForSquare[colorIndex] = image.get(is, js);
          colorIndex++;
        }
      }
      fill(avgColor(colorsForSquare));
      square(i, j, squareSize);
      popMatrix();
    }
  }
}

public color avgColor(color[] colors) {
  float r = 0, g = 0, b = 0;
  for (int i=0; i<colors.length; i++) {
    r+=red(colors[i]);
    g+=green(colors[i]);
    b+=blue(colors[i]);
  }
  return color(r/colors.length, g/colors.length, b/colors.length);
}

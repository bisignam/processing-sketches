PImage cross;

boolean storeImage = true;
int squareSize = 20; //gradezza in pixel dei quadrati 
boolean thresholdFilter = false;
boolean grayFilter = false;
float threshold = 0.5;
float thresholdForPainting = 80;
float thresholdForOne = 60;
String processedImageName = "amen.jpg";
String imageToSaveName = "amen20";
boolean firstRun = true;

void setup() {
  background(255, 255, 255); //colore del background
  size(1833, 2048); //qua va messa la grandezza dell'immagine
  frameRate(10);
  cross = loadImage(processedImageName);
}

void draw() {
  cross.resize(width, height);
  if(grayFilter) {
    cross.filter(GRAY);
  }
  if(thresholdFilter) {
    cross.filter(THRESHOLD, threshold);
  }
  drawPixelizedImage(cross);
  if(storeImage && firstRun) {
    save(imageToSaveName+".jpg");
    storeVariables();
    firstRun = false;
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
      
      color avgColorForPixel = avgColor(colorsForSquare);
      fill(avgColorForPixel);
    //  if(blue(avgColorForPixel) < thresholdForPainting) {
        if(blue(avgColorForPixel) < thresholdForOne) {
          textSize(18);
          text("   1   ", i, j); 
        } else {
          textSize(18);
          text("   0   ", i, j); 
        }
      //}
   
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

void storeVariables() {
  saveStrings(imageToSaveName+".txt", 
    new String[]{"squareSize: " + squareSize + "\n" 
                  + "grayFilter: " + grayFilter + "\n" 
                  + "threshold: " + threshold + "\n"
                  + "thresholdForPainting: " + thresholdForPainting + "\n"
                  + "thresholdForOne: " + thresholdForOne + "\n"
                  + "processedImageName: : " + processedImageName + "\n" 
                  + "thresholdFilter: " + thresholdFilter });
}
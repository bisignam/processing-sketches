import ddf.minim.*; //<>//
import ddf.minim.analysis.*;
import java.util.List;
import java.util.Collections.*;

int MAX_SIZE = 5000;
int currentIndex = 0;
Minim minim;
FFT fft;
AudioPlayer song;
int pixelAmplification = 50;
int polygonAmplification = 800;
int frameRate = 20;
int numberOfRotationFrames = 50;
int currentRotationFrame = 0;
int rotationIncrement = 5;
int previousRotation = 0;
boolean rotationActive = false;
float[] background = new float[]{0, 0, 100};
List<Line> linesToRotate = new ArrayList<Line>();
Polygon polygon1ToRotate;
Polygon polygon2ToRotate;


float backgroundSaturationMovementFactor = 0.01;
float backgroundSaturationOffset = 0;

List<Pixel> pixelsLeft = new ArrayList<Pixel>(MAX_SIZE);

List<Pixel> pixelsRight = new ArrayList<Pixel>(MAX_SIZE);

List<Point> fftPolygonPoints = new ArrayList<Point>();

void setup() {
  size(1024, 768, P3D);

  stroke(1);

  strokeWeight(1);

  background(background[0], background[1], background[2]);

  noFill();

  colorMode(HSB, 360, 100, 100);

  frameRate(frameRate);

  minim = new Minim(this);

  song = minim.loadFile("track.mp3");

  fft = new FFT( song.bufferSize(), song.sampleRate() );
  
  song.play();
}

void draw() {

 if (!rotationActive) {
    background(background[0], background[1]+backgroundSaturationOffset, background[2]);
  }

  int yTopPixel = int(map(song.position(), 0, song.length(), 0, height));

  int yBottomPixel = int(map(song.length() - song.position(), 0, song.length(), 0, height));

  float frequencyLeft = song.left.get(int(yTopPixel));

  float frequencyRight = song.right.get(int(yTopPixel));

  float frequencyMix = song.mix.get(int(yTopPixel));

  createAndAddPixelsToLists(yTopPixel, yBottomPixel, frequencyLeft, frequencyRight);

  tubePolygon(fft, frequencyMix, frequencyLeft, frequencyRight);

  changePixelsColors(pixelsLeft);
  changePixelsColors(pixelsRight);

  currentIndex++;
  backgroundSaturationOffset+=backgroundSaturationMovementFactor;
}

void stop() {

  song.close();

  minim.stop();

  super.stop();
}

void createAndAddPixelsToLists(float yTopPixel, float yBottomPixel, float frequencyLeft, float frequencyRight) {

  Pixel pixel1 = new Pixel(random(width), yTopPixel, frequencyLeft*pixelAmplification);
  pixelsLeft.add(currentIndex, pixel1);

  Pixel pixel2 = new Pixel(random(width), yBottomPixel, frequencyRight*pixelAmplification);
  pixelsRight.add(currentIndex, pixel2);

  if (currentIndex >= MAX_SIZE) {
    currentIndex = 0;
  }
}

void changePixelsColors(List<Pixel> pixels) {
  int i = MAX_SIZE;
  for (Pixel pixel : pixels) {
    pushMatrix();
    int gradient = 255 - (int)(((float)i/(float)MAX_SIZE)*255d);
    fill(RGB, 0, 0, gradient);
    stroke(0);
    strokeWeight(0);
    pixel.draw();
    popMatrix();
    i--;
  }
}

List<Point> drawPolygon(float x, float y, float z, float radius, int npoints) {
  List<Point> polygonPoints = new ArrayList<Point>();
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy, z);
    polygonPoints.add(new Point(sx, sy, z));
  }
  endShape(CLOSE);
  return polygonPoints;
}

List<Point> drawPloygonFromFft(FFT fft, float frequencyMix, float frequencyLeft, float frequencyRight, float z, float xOffset, float topFrequency) {
  fft.forward( song.mix );
  int offsetLeft = int(map(frequencyLeft < 0 ? 0 : frequencyLeft, 0, 0.5, 0, width));
  int offsetRight = int(map(frequencyRight < 0 ? 0 : frequencyRight, 0, 0.5, 0, width));
  float radius = 0+frequencyMix*polygonAmplification;
  float h = random(0, frequencyRight*polygonAmplification)/2;

  //Step for defining inner polygons gradient
  int innerPolygonsStep  = int(map(frequencyMix < 0 ? 0 : frequencyMix, 0, 0.5, 0, 30));
  innerPolygonsStep = innerPolygonsStep <= 0 ? 10 : innerPolygonsStep;

  List firstPolygonPoints = new ArrayList<Point>();
  for (int r = (int)radius; r > 0; r-=innerPolygonsStep) {
    pushMatrix();
    stroke(0);
    strokeWeight(0);
    fill(h, map(fft.calcAvg(1000, 2000), 0, 3, 0, 100), map(fft.calcAvg(2000, 4000), 0, 3, 0, 100), 100);
    List<Point> polygonPoints = drawPolygon(width/2-offsetLeft+offsetRight+xOffset, height/2, z, r, 
      (int)topFrequency); 
    if (r == (int)radius) {
      firstPolygonPoints = polygonPoints;
    }
    h = (h + innerPolygonsStep) % 360;
    popMatrix();
  }
  return firstPolygonPoints;
}

void tubePolygon(FFT fft, float frequencyMix, float frequencyLeft, float frequencyRight) {
  pushMatrix();

  if (frameCount % 200 == 0 && linesToRotate.size() >= 3) {
    rotationActive = true;
  }

  if (rotationActive) {
    currentRotationFrame++;
    previousRotation+=rotationIncrement;
    translate(width/2, height/2);
    rotateY(radians(previousRotation));
    strokeWeight(3);
    stroke(RGB, random(0, 100), random(0, 100), random(0, 100));
    drawPreviousTube();
    popMatrix();
    if (currentRotationFrame == numberOfRotationFrames) {
      currentRotationFrame = 0;
      previousRotation = 0;
      rotationActive = false;
      linesToRotate.clear();
    }
    return;
  }

  float topFrequency = getTopFrequency();

  List<Point> polygonPoints1 = drawPloygonFromFft(fft, frequencyMix, frequencyLeft, frequencyRight, random(-50, -100), random(-100, -30), topFrequency);
  polygon1ToRotate = new Polygon(polygonPoints1);

  List<Point> polygonPoints2 = drawPloygonFromFft(fft, frequencyMix, frequencyLeft, frequencyRight, random(50, 100), random(30, 100), topFrequency);
  polygon2ToRotate = new Polygon(polygonPoints2);

  if (random(1) >= 0.8) {  
    fill(100, map(fft.calcAvg(1000, 2000), 0, 3, 0, 100), map(fft.calcAvg(2000, 4000), 0, 3, 0, 100), 100);
  }
  stroke(RGB, random(0, 100), random(0, 100), random(0, 100));
  strokeWeight(random(3));
  strokeJoin(ROUND);

  linesToRotate.clear();
  for (int i=0; i<polygonPoints1.size(); i++) {
    line(polygonPoints1.get(i).getX(), 
      polygonPoints1.get(i).getY(), 
      polygonPoints1.get(i).getZ(), 
      polygonPoints2.get(i).getX(), 
      polygonPoints2.get(i).getY(), 
      polygonPoints2.get(i).getZ()
      );

    linesToRotate.add(new Line(new Point(polygonPoints1.get(i).getX(), 
      polygonPoints1.get(i).getY(), 
      polygonPoints1.get(i).getZ()), 
      new Point(polygonPoints2.get(i).getX(), 
      polygonPoints2.get(i).getY(), 
      polygonPoints2.get(i).getZ())));
  }

  popMatrix();
}

float[] getTopTenFrequencies(FFT fft) {
  float[] topFreqs = new float[fft.specSize()];
  for (int i = 0; i<fft.specSize(); i++) {
    topFreqs[i] = fft.getBand(i);
  }
  topFreqs = sort(topFreqs);
  topFreqs = reverse(topFreqs);
  return topFreqs;
}

float getTopFrequency() {
  float[] topFrequencies = getTopTenFrequencies(fft);
  int randomFftIndexFromTopFrequency = int(random(30));
  return topFrequencies[randomFftIndexFromTopFrequency];
}

void drawPreviousTube() {
  beginShape();
  for (Point point : polygon1ToRotate.getPoints()) {
    vertex(point.getX(), point.getY(), point.getZ());
  }
  endShape(CLOSE);

  beginShape();
  for (Point point : polygon2ToRotate.getPoints()) {
    vertex(point.getX(), point.getY(), point.getZ());
  }
  endShape(CLOSE);

  for (Line line : linesToRotate) {
    line(line.getPoint1().getX(), line.getPoint1().getY(), line.getPoint1().getZ(), 
      line.getPoint2().getX(), line.getPoint2().getY(), line.getPoint2().getZ());
  }
}

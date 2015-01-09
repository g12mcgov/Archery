import java.util.*;
// A scored archery game.
//
// Grant McGovern
// September 2012

// constant variables -- how's that for an oxymoron?
int CENTERX = 250;
int CENTERY = 250;
int BANDWIDTH = 20;                    // each band is 20 units wide
int TARGETRADIUS   = 10 * BANDWIDTH;   // 10 bands on the target
int TARGETDIAMETER = 2 * TARGETRADIUS;
int WHITE = 255;
int BLACK = 0;

// variables used throughout the sketch
int totalPoints = 0;
int arrowCount  = 0;

// variables for wind
float   windSpeed;
float   windDirection;


// The object randomGauss belongs to the Java Random class,  it
// is used to generate random numbers from a Gaussian distribution
// with mean 0 and standard deviation 1.
Random randomGauss;

void setup() {

  // instantiate the object randomGauss, seeding the pseudorandom number
  // generator by the time (the default), or if you want a repeatable
  // sequence use an integer argument in the constructor, e.g. Random(8)
  randomGauss = new Random();

  size(2* CENTERX, 2 * CENTERY);
  background(WHITE);
  ellipseMode(CENTER);  // easiest way to draw concentric circles
  smooth();
  
  windDirection = random(0,PI*2);
  windSpeed = random(0,75);

  // display the initial target
  fill(WHITE);                   // set fill to WHITE for outer bands
  ellipse(CENTERX, CENTERY, TARGETDIAMETER, TARGETDIAMETER);
  ellipse(CENTERX, CENTERY, TARGETDIAMETER - 40, TARGETDIAMETER - 40);

  stroke(WHITE);
  fill(BLACK);
  ellipse(CENTERX, CENTERY, TARGETDIAMETER - 80, TARGETDIAMETER - 80);
  ellipse(CENTERX, CENTERY, TARGETDIAMETER - 120, TARGETDIAMETER - 120);

  stroke(BLACK);
  fill(0, 0, 255);
  ellipse(CENTERX, CENTERY, TARGETDIAMETER - 160, TARGETDIAMETER - 160);
  ellipse(CENTERX, CENTERY, TARGETDIAMETER - 200, TARGETDIAMETER - 200);

  fill(255, 0, 0);
  ellipse(CENTERX, CENTERY, TARGETDIAMETER - 240, TARGETDIAMETER - 240);
  ellipse(CENTERX, CENTERY, TARGETDIAMETER - 280, TARGETDIAMETER - 280);

  fill(255, 204, 0);
  ellipse(CENTERX, CENTERY, TARGETDIAMETER - 320, TARGETDIAMETER - 320);
  ellipse(CENTERX, CENTERY, TARGETDIAMETER - 360, TARGETDIAMETER - 360);
}

void draw() {
}

// react to key events
void keyPressed() {


  float distanceOff;
  int   ringHit;
  int   pointValue;
  float arrowX;
  float arrowY;
  

  // perturb the arrow slightly from the current mouse position
  arrowX = mouseX + TARGETRADIUS/7.0 * (float) randomGauss.nextGaussian();
  arrowY = mouseY + TARGETRADIUS/7.0 * (float) randomGauss.nextGaussian();
  
  arrowX = arrowX + windSpeed * cos(windDirection);
  arrowY = arrowY + windSpeed * sin(windDirection);

  distanceOff = dist(CENTERX, CENTERY, arrowX, arrowY);

  ringHit = int((distanceOff/20)+1);
  pointValue = 11-ringHit;
  pointValue = constrain(pointValue, 0, 10);


  if ( key == 's' ) {  // press s to shoot


    if (arrowCount < 6) {
      arrowCount = (arrowCount + 1);   
      
      if (ringHit <= 10) {  
        println("Ring Hit " + ringHit);
      }

      else if (ringHit > 10) {
        println("Missed Target");
      }

      println("score " + pointValue);

      println(distanceOff);

      totalPoints = (totalPoints + pointValue);
    }

   else if (arrowCount == 6){
     println("No Arrow in Quiver");
   }



    // show a green X to indicate where the arrow hit
    stroke(0, 255, 0);   // Green shows up okay but not great
    line(arrowX+6, arrowY-6, arrowX+12, arrowY-12);
    line(arrowX+12, arrowY-6, arrowX+6, arrowY-12);
  } 

  else if (key == 't') {

    println("Total Points " + totalPoints);
  }

  else if ( key == 'q' ) {  // press q to quit
    exit();
  }
}


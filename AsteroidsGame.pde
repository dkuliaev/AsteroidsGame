SpaceShip sr71 = new SpaceShip();
Star galaxy[] = new Star[100];
ArrayList <Asteroid> theList = new ArrayList <Asteroid>();
ArrayList <Bullets> theSwarm = new ArrayList <Bullets>();
public boolean shooting = false;
public boolean gameOver = false;
public boolean wKey = false;
public boolean dKey = false;
public boolean aKey = false;
public boolean sKey = false;
public boolean hyperKey = false;
public double score = 0;
public boolean suicide = false;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public void setup() 
{
  size(1000, 800);
  background(0);
  for(int s = 0; s < galaxy.length; s++) { galaxy[s] = new Star(); }
  for(int q = 0; q < 10; q++) { theList.add(new Asteroid());  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public void draw() 
{
  background(0);
  for(int s = 0; s < galaxy.length; s++) { galaxy[s].show(); }
  for(int q = 0; q < theList.size(); q++) 
  {
    theList.get(q).show(); 
    theList.get(q).move();
  }
  for(int g = 0; g < theSwarm.size(); g++)
  {
    theSwarm.get(g).show();
    theSwarm.get(g).move();
  }

  sr71.show();
  sr71.move();

  if(wKey == true){sr71.accelerate(0.075);}
  if(dKey == true){sr71.rotate(5);}
  if(aKey == true){sr71.rotate(-5);}
  if(sKey == true){sr71.accelerate(-0.075);}
  if(hyperKey == true)
  {
    sr71.setX(500);
    sr71.setY(600);
    sr71.setDirectionX(0);
    sr71.setDirectionY(0);
    sr71.setPointDirection(90);
  }

  for(int b = 0; b < theList.size(); b++)
    if(dist(sr71.getX(), sr71.getY(), theList.get(b).getX(), theList.get(b).getY()) < 70)
        gameOver = true;

  for(int b = 0; b < theList.size(); b++)
  {
    for(int p = 0; p < theSwarm.size(); p++)
    {
      if(dist(theSwarm.get(p).getX(), theSwarm.get(p).getY(), theList.get(b).getX(), theList.get(b).getY()) < 50)
      {
        theList.remove(b);
        theSwarm.remove(p);
        score++;
        break;
      }
    }
    for(int i = 0; i < theSwarm.size(); i++)
    {
      if(dist(sr71.getX(), sr71.getY(), theSwarm.get(i).getX(), theSwarm.get(i).getY()) < 5)
      {
        gameOver = true;
        theSwarm.remove(i);
        suicide = true;
      }
    }
  if(theList.size() < 10 && gameOver == false)
    theList.add(new Asteroid());
  }
    

  if(gameOver == true)
  {
    fill(255);
    textSize(100);
    text("Game Over", 200, 400);
    textSize(50);
    text("Final Score: " + (int)score, 340, 500);
    for(int i = 0; i < theList.size(); i++){theList.remove(i); }
    for(int i = 0; i < theSwarm.size(); i++){theSwarm.remove(i);}
    if(suicide == true) { textSize(25); text("You hit your own ship", 350, 600);}
  }
  
  if(gameOver == false)
  {
  fill(255);
  textSize(20);
  text("SCORE: " + (int)score, 50, 50);
  }
}

public void keyPressed() 
  {
    if(key == ' '){ theSwarm.add(new Bullets(sr71)); score -= 0.2;}
    if(key == 'r'){ gameOver = false; theList.add(new Asteroid()); score = 0; }
    if(key == 'w' || key == 'W'){ wKey = true;}
    if(key == 'd' || key == 'D'){ dKey = true;}
    if(key == 'a' || key == 'A'){ aKey = true;}
    if(key == 's' || key == 'S'){ sKey = true;}
    if(key == 'c' || key == 'C'){ hyperKey = true;}
  }

public void keyReleased() 
  {
    if(key == 'w' || key == 'W'){ wKey = false;}
    if(key == 'd' || key == 'D'){ dKey = false;}
    if(key == 'a' || key == 'A'){ aKey = false;}
    if(key == 's' || key == 'S'){ sKey = false;}
    if(key == 'c' || key == 'C'){ hyperKey = false;}
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Star
{
  private int starX, starY;

  public Star()
  {
    starX = (int)(Math.random() * 1000);
    starY = (int)(Math.random() * 800);
  }

  public void show()
  {
    fill(255);
    noStroke();
    ellipse(starX, starY, 3, 3);
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Bullets extends Floater
{
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}
  public void setColor(int x){myColor = x;}
  public int getColor(){return (int)myColor;}
  public void setDirectionX(double x){myDirectionX = x;}   
  public double getDirectionX(){return myDirectionX;}   
  public void setDirectionY(double y){myDirectionY = y;} 
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;} 
  public double getPointDirection(){return myPointDirection;}
  public double dRadians;

 public Bullets(SpaceShip theShip)
 {
  myCenterX = theShip.getX();
  myCenterY = theShip.getY();
  myPointDirection = theShip.getPointDirection();
  dRadians = myPointDirection*(Math.PI/180);
  myDirectionX = 5*Math.cos(dRadians) + theShip.getDirectionX();
  myDirectionY = 5*Math.sin(dRadians) + theShip.getDirectionY();
 }

 public void show()
 {
  noStroke();
  fill(255, 0, 0);
  ellipse((float)myCenterX, (float)myCenterY, 5, 5);
 }
 public void move()
 {
  myCenterX += myDirectionX;
  myCenterY += myDirectionY;
  super.move();
 }

}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Asteroid extends Floater
{
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}
  public void setColor(int x){myColor = x;}
  public int getColor(){return (int)myColor;}
  public void setDirectionX(double x){myDirectionX = x;}   
  public double getDirectionX(){return myDirectionX;}   
  public void setDirectionY(double y){myDirectionY = y;} 
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;} 
  public double getPointDirection(){return myPointDirection;}

  public Asteroid()
  {
    if(sr71.getX() < 500){ setX((int)(Math.random() * 500 + 500));}
    if(sr71.getX() > 500){ setX((int)(Math.random() * 500));}
    setY((int)(Math.random() * 500));
    setDirectionX((Math.random() * 4 - 2));
    setDirectionY((Math.random() * 4 - 2));
    setPointDirection(0);
    myColor = 150;
    corners = 12;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 10;
    yCorners[0] = -40;
    xCorners[1] = 30;
    yCorners[1] = -50;
    xCorners[2] = 50;
    yCorners[2] = -10;
    xCorners[3] = 50;
    yCorners[3] = 10;
    xCorners[4] = 30;
    yCorners[4] = 20;
    xCorners[5] = 00;
    yCorners[5] = 30;
    xCorners[6] = -10;
    yCorners[6] = 10;
    xCorners[7] = -50;
    yCorners[7] = 10;
    xCorners[8] = -50;
    yCorners[8] = -20;
    xCorners[9] = -30;
    yCorners[9] = -30;
    xCorners[10] = -10;
    yCorners[10] = -50;
    xCorners[11] = 10;
    yCorners[11] = -40;
  }
  public int rotationing = (int)((Math.random() * 2) -3);
  
  public void move()
  {
    rotate(rotationing); 
    super.move();
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class SpaceShip extends Floater  
{   
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}
  public void setColor(int x){myColor = x;}
  public int getColor(){return (int)myColor;}
  public void setDirectionX(double x){myDirectionX = x;}   
  public double getDirectionX(){return myDirectionX;}   
  public void setDirectionY(double y){myDirectionY = y;} 
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;} 
  public double getPointDirection(){return myPointDirection;}
  private int hyperX, hyperY, hyperPoint;

  public SpaceShip()
  {
    setX(500);
    setY(600);
    setDirectionX(0);
    setDirectionY(0);
    setPointDirection(270);
    hyperX = (int)(Math.random() * 500 + 250);
    hyperY = (int)(Math.random() * 500 + 250);
    hyperPoint = (int)(Math.random() * 360);
    myColor = color(150, 150, 0);
    corners = 8;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 9*2;
    yCorners[0] = 0*2;
    xCorners[1] = -6*2;
    yCorners[1] = 12*2;
    xCorners[2] = -9*2;
    yCorners[2] = 8*2;
    xCorners[3] = -6*2;
    yCorners[3] = 4*2;
    xCorners[4] = -9*2;
    yCorners[4] = 0*2;
    xCorners[5] = -6*2;
    yCorners[5] = -4*2;
    xCorners[6] = -9*2;
    yCorners[6] = -8*2;
    xCorners[7] = -6*2;
    yCorners[7] = -12*2; 
  }
 
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE); 

  }   
} 


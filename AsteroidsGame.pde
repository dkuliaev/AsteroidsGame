SpaceShip sr71 = new SpaceShip();
Star galaxy[] = new Star[100];
public void setup() 
{
  size(1000, 800);
  background(0);
  for(int s = 0; s < galaxy.length; s++) { galaxy[s] = new Star(); }
}
public void draw() 
{
  background(0);
  for(int s = 0; s < galaxy.length; s++) { galaxy[s].show(); }
  sr71.show();
  sr71.move();
  sr71.keyPressed();
  
}
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
    ellipse(starX, starY, 3, 3);
  }
}
class SpaceShip extends Floater  
{   
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}   
  public int getY(){return (int)myCenterY;}
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
    setY(500);
    setDirectionX(0);
    setDirectionY(0);
    setPointDirection(270);
    hyperX = (int)(Math.random() * 500 + 250);
    hyperY = (int)(Math.random() * 500 + 250);
    hyperPoint = (int)(Math.random() * 360);
    corners = 8;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 9*3;
    yCorners[0] = 0*3;
    xCorners[1] = -6*3;
    yCorners[1] = 12*3;
    xCorners[2] = -9*3;
    yCorners[2] = 8*3;
    xCorners[3] = -6*3;
    yCorners[3] = 4*3;
    xCorners[4] = -9*3;
    yCorners[4] = 0*3;
    xCorners[5] = -6*3;
    yCorners[5] = -4*3;
    xCorners[6] = -9*3;
    yCorners[6] = -8*3;
    xCorners[7] = -6*3;
    yCorners[7] = -12*3; 


  }
  
  public void keyPressed()
  {
    
   if(keyPressed == true && keyCode == DOWN)
    {
      sr71.setX(hyperX);
      sr71.setY(hyperY);
      sr71.setPointDirection(hyperPoint);
    }
  else
   {
      hyperX = (int)(Math.random() * 500 + 250);
      hyperY = (int)(Math.random() * 500 + 250);
      hyperPoint = (int)(Math.random() * 360);
   }
  if(keyPressed == true && keyCode == UP)
    {
      sr71.accelerate(0.075);
    }
  if(keyPressed == true && keyCode == LEFT)
    {
     sr71.rotate(-5);
    }
  if(keyPressed == true && keyCode == RIGHT)
    {
     sr71.rotate(5);
    }
  
 
  }
}
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
    //fill(myColor);   
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


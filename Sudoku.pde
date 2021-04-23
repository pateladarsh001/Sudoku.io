final int GRID_LENGTH = 9;

float squareSize = 0;
int[] gridX = new int[GRID_LENGTH];
int[] gridY = new int[GRID_LENGTH];
int[] grid = new int[GRID_LENGTH*GRID_LENGTH];
int[] providedNumbers = new int[GRID_LENGTH*GRID_LENGTH];

char userInput = ' ';

void setup() {
  size(900, 900);
  squareSize = width/GRID_LENGTH;
  fillRandomNumbers();
  drawGrid();
  drawProvidedNumbers();
}

void draw() {

  if (keyPressed) {
    userInput = key;
  }
}

//This function will draw the sudoku grid
void drawGrid() {

  float squareX = 0;
  float squareY = 0;

  for (int i = 0; i<GRID_LENGTH+1; i++) {
    for (int j = 0; j<GRID_LENGTH; j++) {
      squareX = j*squareSize;
      fill(200);
      square(squareX, squareY, squareSize);
    }
    squareY = i*squareSize;
  }

  float miniGridX = 0;
  float miniGridY = 0;

  for (int i = 0; i<=GRID_LENGTH/3; i++) {
    for (int j = 0; j<GRID_LENGTH/3; j++) {
      miniGridX = j*squareSize*3;
      strokeWeight(GRID_LENGTH/3);
      noFill();
      square(miniGridX, miniGridY, squareSize*3);
    }
    miniGridY = i*squareSize*3;
  }
}

//This function draws a character in a given box in the grid
void drawNumber(int squareX, int squareY, char num) {

  text(num, (squareX*squareSize) + (squareSize/2) - textWidth(num)/2, (squareY*squareSize) + (squareSize/2) + (textAscent()/2) - textDescent()/2 );
}
//returns the index of gridX using mouseX location of the mouse
int getSquareX() {  
  return int(mouseX/squareSize);
}
//returns the index of gridY using mouseY location
int getSquareY() {
  return int(mouseY/squareSize);
}

//This function generates random numbers that will be drawn on the grid when the game starts
void fillRandomNumbers() {

  for (int i = 0; i<GRID_LENGTH; i++) {//We will generate a random number of total random numbers in a given line of the grid
    int numRandomNumbers = int(random(1, GRID_LENGTH-2));

    for (int j = 0; j<numRandomNumbers; j++) {
      int randomIndex = int(random(1, GRID_LENGTH));

      providedNumbers[i*GRID_LENGTH +  randomIndex] = int(random(1, GRID_LENGTH));//We need to store the permanent number in our reference array to keep checking every time the user clicks on a box
      grid[i*GRID_LENGTH +  randomIndex] = int(random(1, GRID_LENGTH));
    }
  }
}

void drawProvidedNumbers() {

  char drawNum = ' ';
  int boxNumber = -1;

  for (int i = 0; i<GRID_LENGTH; i++) {
    for (int j = 0; j<GRID_LENGTH; j++) {
      boxNumber = (grid[(i*GRID_LENGTH) + j]);

      if (boxNumber >0) {
        drawNum = str(boxNumber).charAt(0);
        fill(255, 0, 0);
        textSize(squareSize*0.5);
        drawNumber(i, j, drawNum);
      }
    }
  }
}

boolean providedExists(int x, int y) {
  return providedNumbers[x*GRID_LENGTH + y] != 0;//If our provided array at that index has 0, it means that the number in that square can be updated
}

boolean gridExists(int x, int y) {
  return grid[x*GRID_LENGTH + y] !=0;//This will be used in updating values that the user can actually update
}

void mouseClicked() {

  if (userInput != ' ') {
      noStroke();
    fill(0);
    textSize(squareSize*0.5);

    int x = getSquareX();
    int y = getSquareY();

    if (!providedExists(x, y)) {
      if (gridExists(x, y)) {
        fill(200);
        square(x*squareSize, y*squareSize, squareSize-1);
        drawNumber(x, y, userInput);
        grid[x*GRID_LENGTH + y] = userInput;
        noFill();
      }
      drawNumber(x, y, userInput);
      grid[x*GRID_LENGTH + y] = userInput;
    } else {
      //println("Value in this box cannot be updated.");
    }
    //println("User input is : " + userInput);
  }else{
      //println("User has not selected any input");
  }
}
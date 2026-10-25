#include "Sudoku.h"
#include <cstdlib>

Sudoku::Sudoku()
    : difficulty(Medium)
{
    clearBoard();
}

void Sudoku::initializeBoard(){
    for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
            board[row][col].setValue(0);
            board[row][col].setIsFixed(false);
        }
    }
}
void Sudoku::setDifficulty(Difficulty newDifficulty)
{
    difficulty = newDifficulty;
}

Difficulty Sudoku::getDifficulty()
{
    return difficulty;
}

bool Sudoku::checkIfCellOccupied(int row, int col)
{
    return this->board[row][col].getIsFixed();
}

bool Sudoku::checkIfMoveValid(int row, int col, int value) {
    //Check if user tried to delete / overwrite fixed cell
    if(this->board[row][col].getIsFixed()){ return false;}
    // Check if move is Valid in the row,
    for (int c = 0; c < 9; c++) {
        if(c == col){
            continue;
        }   
        if( value == this->board[row][c].getValue()){
            return false;
        }       
    }
    // Check if move is Valid in the column
    for(int r = 0; r < 9 ; r++){
        if (r == row){
            continue;
        }
        if(value == this->board[r][col].getValue()){
            return false;
        }
    }
    
    // Determine row and col range of cell 
    int startRow = (row / 3) * 3;
    int startCol = (col / 3) * 3;
    // Check in the 3x3 Cell 
    for (int r = startRow; r < 3; r++){
        for(int c = startCol; c < 3; c++){
            if (value == this->board[r][c].getValue()){
                return false;
            }
        }
    }
    return true;
}

void Sudoku::clearBoard()
{
    for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
            board[row][col].setValue(0);
            board[row][col].setIsFixed(false);
        }
    }
}

bool Sudoku::checkForWin() {
    for (const auto &row : board) {
        for (const SudokuCell &cell : row) {
            if (cell.getValue() == 0)
                return false;
        }
    }
    return true;
}

void Sudoku::newGame(){
    //ranges for difficulty levels
    int easy[2] = {36, 45};
    int medium[2] = {30, 35};
    int hard[2] = {23, 29};
    clearBoard();

    switch (difficulty) {
        case Easy:
            this->setupBoard(easy);
            break;
        case Medium:
            this->setupBoard(medium);
            break;
        case Hard:
            this->setupBoard(hard);
            break;
    }
}


void Sudoku::setupBoard(int difficultyLevel[2]){
    // 36 45
    int numbersTobePlaced = rand() % (difficultyLevel[1] - difficultyLevel[0] + 1) + difficultyLevel[0];

    for (int i = 0; i < numbersTobePlaced; i++) {
        int randomCellX = rand() % 9;
        int randomCellY = rand() % 9;
        
        while(!this->checkIfCellOccupied(randomCellX, randomCellY)){
            int randomValue = rand() % 9 + 1;
            this->setBoardValue(randomCellX, randomCellY, randomValue, true);
        }
    }
}

int Sudoku::getBoardValue(int row, int col)
{
    return this->board[row][col].getValue();
}

void Sudoku::setBoardValue(int row, int col, int value, bool isFixed)
{
    this->board[row][col].setValue(value);
    this->board[row][col].setIsFixed(isFixed);
}
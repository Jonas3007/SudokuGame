#include "Sudoku.h"
#include <cstdlib>

Sudoku::Sudoku()
    : difficulty(Easy)
{
    clearBoard();
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
    
}

bool Sudoku::checkIfMoveValid() {
    // Implement the logic to check if a move is valid
    return true;
}

void Sudoku::clearBoard()
{
    
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
            // Set up easy game
            break;
        case Medium:
            // Set up medium game
            break;
        case Hard:
            // Set up hard game
            break;
    }
}


void Sudoku::setupBoard(int difficultyLevel[2]){
    // 36 45
    int easyDifficultyNumber = rand() % (difficultyLevel[1] - difficultyLevel[0] + 1) + difficultyLevel[0];

    for (int i = 0; i < easyDifficultyNumber; i++) {
        int randomCellX = rand() % 9;
        int randomCellY = rand() % 9;
        int randomValue = rand() % 9 + 1;
        if (!this->checkIfCellOccupied(randomCellX, randomCellY)) {
            this->setBoardValue(randomCellX, randomCellY, randomValue);
        }
    }
    
}

int Sudoku::getBoardValue(int row, int col)
{
    
}

void Sudoku::setBoardValue(int row, int col, int value)
{
    
}
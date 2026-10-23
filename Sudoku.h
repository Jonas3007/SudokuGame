#pragma once
#include "SudokuCell.h"
#include "Difficulty.h"

class Sudoku {  
    private:
    SudokuCell board[9][9];
    Difficulty difficulty;

    public:
    Sudoku();
    
    void setDifficulty(Difficulty newDifficulty);
    Difficulty getDifficulty();
    bool checkIfCellOccupied(int row, int col);
    bool checkIfMoveValid();
    void clearBoard();
    void newGame();
    bool checkForWin();
    void setupBoard(int difficultyLevel[2]);
    int getBoardValue(int row, int col);
    void setBoardValue(int row, int col, int value);
};
#pragma once
#include "SudokuCell.h"

class Sudoku {  
    private:
    SudokuCell board[9][9];

    public:

    bool checkIfMoveValid();
    void clearBoard();
    void newGame();
    bool checkForWin();
    void setBoard(int newBoard[9][9]);
    int getBoardValue(int row, int col);
    void setBoardValue(int row, int col, int value);
};
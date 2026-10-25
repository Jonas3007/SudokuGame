#include "SudokuCell.h"

SudokuCell::SudokuCell()
    : value(0), isFixed(false)
{
}

int SudokuCell::getValue() const
{
    return value;
}

void SudokuCell::setValue(int newValue)
{
    value = newValue;
}

bool SudokuCell::getIsFixed() const
{
    return isFixed;
}

void SudokuCell::setIsFixed(bool fixed)
{
    isFixed = fixed;
}
#pragma once

class SudokuCell {
    private:
        int value;
        bool isFixed;

    public:
        SudokuCell();
        int getValue() const;
        void setValue(int newValue);
        bool getIsFixed() const;
        void setIsFixed(bool fixed);
};
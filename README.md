# Tic-Tac-Toe
You are to implement a tic-tac-toe game that meets the following requirements:

1. You start the program by loading the file and typing (tic-tac-toe).
2. The program asks who goes first, the human or the computer, and then plays the game accordingly.
3. When the human is asked for a move, the move will be entered in terms of a row (0-2) and column (0-2), e.g., 1 2
4. A 3-by-3 display of the current board must be shown after every move (human or computer).
5. If the game is given a chance to win, it must win.

The program may be written to work with either heuristics, search, or a combination of the two.

Advice

1. Build the entire infrastructure to play a game first, but fake the AI part by asking the human what the AI's move would be.2.
2. The entire infrastructure includes things like a way to represent the board, a function to print the board, a function to ask the human for their move, a way to determine whether a player has won, and more.
3. Look up how to use -- these are not necessarily needed, but are helpful to know
  * make-array and aref (to work with arrays)
  * multiple-value-bind (to accept multiple returned values from a function)
  * let* (so that you can reference earlier values declared using let)
  * dolist (to iterate though the items in a list)
  * progn (to conveniently list a sequence of lisp statements)
  

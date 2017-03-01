# Tic-Tac-Toe
You are to implement a tic-tac-toe game that meets the following requirements:

1. You start the program by loading the file and typing (tic-tac-toe).
2. The program asks who goes first, the human or the computer, and then plays the game accordingly.
3. When the human is asked for a move, the move will be entered in terms of a row (0-2) and column (0-2), e.g., 1 2
4. A 3-by-3 display of the current board must be shown after every move (human or computer).
5. If the game is given a chance to win, it must win.

The program may be written to work with either heuristics, search, or a combination of the two.

Advice

1. Build the entire infrastructure to play a game first, but fake the AI part by asking the human what the AI's move would be.
2. The entire infrastructure includes things like a way to represent the board, a function to print the board, a function to ask the human for their move, a way to determine whether a player has won, and more.
3. Look up how to use -- these are not necessarily needed, but are helpful to know
  * make-array and aref (to work with arrays)
  * multiple-value-bind (to accept multiple returned values from a function)
  * let* (so that you can reference earlier values declared using let)
  * dolist (to iterate though the items in a list)
  * progn (to conveniently list a sequence of lisp statements)
 
##Grading Criteria
Start: call via (tic-tac-toe)
 The program must start running by calling (tic-tac-toe)
 Maximum score
 10
 
Start: AI asks who starts
 The AI must ask who goes first: human or computer -- specify by 'H' or 'C'
 Maximum score
 10
 
Row/col specification
 The human will enter row first as 0, 1, or 2, then the column as 0, 1, or 2; rows are numbered top-to-bottom (0-2), columns are numbered left-to-right (0-2).
 Maximum score
 10
 
Game OK
 The game plays OK, plays legally, meets all other requirements, and does win at least sometimes. Note: crashing, etc. means the AI didn't play OK. All human input will be legal, so there should be no cause for crashing.
 Maximum score
 40
 
Always wins
 The AI always wins if a win is possible. Note: crashing, etc. means the AI didn't win.
 Maximum score
 30

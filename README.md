## Project Description

*This project is an AI module for a minesweeper robot in Haskell. The environment in which the robot operates is an 4 x 4 grid of cells. Initially,a cell on the grid is either empty, contains the robot, or contains a mine. The robot can move in all four directions and is able to collect a mine only if it is in the same cell as the mine. Your program will take as input the initial position of the robot and the positions of all of the mines. The objective of the AI module is to compute a sequence of actions that the robot can follow in order to go to all the mines and collect them. Below is an example grid.*

![grid](https://github.com/NadaEmad222/AI_Minesweeper/blob/main/image.png?raw=true)

The robot R starts at (3,0) while the mines are at (2,2) and (1,2). One possible generated
sequence of actions by your program is:
["up","right","right","collect","up","collect"]

## Implementation Description

1. A Cell represents a position on the grid with the first coordinate in the pair representing a row number, and the second coordinate representing a column number. 

2. The MyState structure represents the state of the robot at any given time. It is either Null or the data constructor S followed by a cell representing the robot’s position

3. a list of cells representing the positions of the mines to be collected

4. a string representing the last action performed to reach this state, and the parent state. 

5. The parent state is the last state the robot was in before doing the last performed action.

6.  The initial state of the robot in the above grid is accordingly represented as: S (3,0) [(2,2),(1,2)] "" Null

7. Implemented functions:
    1. up:: MyState -> MyState 
    *The function takes as input a state and returns the state resulting from moving up from the input state. If up will result in going out of the boundaries of the grid, Null should be returned.*

    2. down:: MyState -> MyState
    *The function takes as input a state and returns the state resulting from moving down from the input state. If down will result in going out of the boundaries of the grid, Null should be returned.*

    3. left:: MyState -> MyState
    *The function takes as input a state and returns the state resulting from moving left from the input state. If left will result in going out of the boundaries of the grid, Null should be returned.*

    4. right:: MyState -> MyState
    *The function takes as input a state and returns the state resulting from moving right from the input state. If right will result in going out of the boundaries of the grid, Null should be returned.*

    5. collect:: MyState -> MyState
    *The function takes as input a state and returns the state resulting from collecting from the input state. Collecting should not change the position of the robot, but removes the collected mine from the list of mines to be collected. If the robot is not in the same position as one of the mines, Null should be returned.*

    6. nextMyStates::MyState->[MyState]
    *The function takes as input a state and returns the set of states resulting from applying up, down, left, right, and collect from the input state. The output set of states should not contain any Null states.*

    7. isGoal::MyState->Bool
    *The function takes as input a state, returns true if the input state has no more mines to collect (the list of mines is empty), and false otherwise.*

    8. search::[MyState]->MyState
    *The function takes as input a list of states. It checks if the head of the input list is a goal state, if it is a goal, it returns the head. Otherwise, it gets the next states from the state at head of the input list, and calls itself recursively with the result of concatenating the tail of the input list with the resulting next states (take care that the order of the concatenation here is important, the next states must be placed by the end of the list).*

    9. constructSolution:: MyState ->[String]
    *The function takes as input a state and returns a set of strings representing actions that the robot can follow to reach the input state from the initial state. The possible strings in the output list of strings are only "up", "down", "left", "right", and "collect".*

    10. solve :: Cell->[Cell]->[String] 
    *The function takes as input a cell representing the starting position of the robot, a set of cells representing the positions of the mines, and returns a set of strings representing actions that the robot can follow to reach a goal state from the initial state.*

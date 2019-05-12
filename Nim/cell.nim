import sequtils

type CellState* = enum
    DEAD
    ALIVE

type Cell* = ref object
    x: int
    y: int
    nextState: CellState
    currentState: CellState

method getX*(cell: Cell): int {.base.} = cell.x
method getY*(cell: Cell): int {.base.} = cell.y

method setCurrentState*(cell: Cell, state: CellState) {.base.} =
    cell.currentState = state
    

method getStateMark*(cell: Cell): string {.base.} = 
    result = case cell.currentState:
        of ALIVE:
            "■ "
        else:
            "□ "

method toNextGen*(cell: Cell) {.base.} =
    cell.currentState = cell.nextState

method init*(cell: Cell, x: int, y: int, currentState: CellState) {.base.} = 
    cell.x = x
    cell.y = y
    cell.currentState = currentState

method prepareCell*(cell: Cell, aroundCells: seq[Cell]) {.base.} =
    let aliveCount = aroundCells.filterIt(it.currentState == ALIVE).len()
    if cell.currentState == ALIVE:
        cell.nextState = case aliveCount:
            of 2, 3:
                ALIVE
            else:
                DEAD
    else:
        cell.nextState = case aliveCount:
            of 3:
                ALIVE
            else:
                DEAD

method isOnTop*(cell: Cell) : bool {.base.} = cell.y == 0
method isOnBottom*(cell: Cell, boardSize: int) : bool {.base.} = cell.y == boardSize - 1
method isOnStart*(cell: Cell) : bool {.base.} = cell.x == 0
method isOnEnd*(cell: Cell, boardSize: int): bool {.base.} = cell.x == boardSize - 1

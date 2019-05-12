import cell as cl
import utils
import sequtils, strutils, math, algorithm

type Gameboard* = ref object
    sideLen*: int
    offset*: int
    boardArray: seq[seq[Cell]]

method getBoardArray*(gameboard: Gameboard): seq[seq[Cell]] {.base.} =
    gameboard.boardArray

method getCellOfRelationalPosition(gameboard: Gameboard, cell: Cell, positions: seq[int]): seq[Cell] {.base.} =
    let 
        board = gameboard.boardArray
        x = cell.getX()
        y = cell.getY()
    
    result = positions.mapIt(
        case it:
            of 1:
                board[y - 1][x - 1]
            of 2:
                board[y - 1][x]
            of 3:
                board[y - 1][x + 1]
            of 4:
                board[y][x - 1]
            of 5:
                board[y][x + 1]
            of 6:
                board[y + 1][x - 1]
            of 7:
                board[y + 1][x]
            of 8:
                board[y + 1][x + 1]
            else:
                raise newException(IndexError, "第二引数はseq[int]で1~8の値を持つものにしてください")
    )

method getAroundCells(gameboard: Gameboard, cell: Cell): seq[Cell] {.base.} =
    var aroundPositions: seq[int]
    let
        isOnTop = cell.isOnTop()
        isOnBottom = cell.isOnBottom(gameboard.sideLen)
        isOnStart = cell.isOnStart()
        isOnENd = cell.isOnEnd(gameboard.sideLen)

    if isOnStart and isOnTop:
        aroundPositions = @[5, 7, 8]
    elif isOnStart and isOnBottom:
        aroundPositions = @[2, 3, 5]
    elif isOnEnd and isOnTop:
        aroundPositions = @[4, 6, 7]
    elif isOnEnd and isOnBottom:
        aroundPositions = @[1, 2, 4]
    elif isOnStart:
        aroundPositions = @[2, 3, 5, 7, 8]
    elif isOnEnd:
        aroundPositions = @[1, 2, 4, 6, 7]
    elif isOnTop:
        aroundPositions = @[4, 5, 6, 7, 8]
    elif isOnBottom:
        aroundPositions = @[1, 2, 3, 4, 5]
    else:
        aroundPositions = @[1, 2, 3, 4, 5, 6, 7, 8]

    gameboard.getCellOfRelationalPosition(cell, aroundPositions)

method toNextGen*(gameboard: Gameboard) {.base.} =
    forEachDubleArray[Cell](gameboard.boardArray, proc(cell: Cell) = cell.prepareCell(gameboard.getAroundCells(cell)))
    forEachDubleArray[Cell](gameboard.boardArray, proc(cell: Cell) = cell.toNextGen())

method createBreeder(gameboard: Gameboard, x: int, y:int, offset: int): CellState {.base.} =
    var state: CellState
    if x == 1 + offset and y == 1 + offset:
        state = ALIVE
    elif x == 2 + offset and y == 1 + offset:
        state = ALIVE
    elif x == 3 + offset and y == 1 + offset:
        state = ALIVE
    elif x == 5 + offset and y == 1 + offset:
        state = ALIVE
    elif x == 1 + offset and y == 2 + offset:
        state = ALIVE
    elif x == 4 + offset and y == 3 + offset:
        state = ALIVE
    elif x == 5 + offset and y == 3 + offset:
        state = ALIVE
    elif x == 2 + offset and y == 4 + offset:
        state = ALIVE
    elif x == 3 + offset and y == 4 + offset:
        state = ALIVE
    elif x == 5 + offset and y == 4 + offset:
        state = ALIVE
    elif x == 1 + offset and y == 5 + offset:
        state = ALIVE
    elif x == 3 + offset and y == 5 + offset:
        state = ALIVE
    elif x == 5 + offset and y == 5 + offset:
        state = ALIVE
    else:
        state = DEAD

    return state
        

method onCreate*(gameboard: Gameboard) {.base.} =
    # インスタンスのnew時に呼ぶこと
    # ライフゲームの初期状態の設定 
    let size = gameboard.sideLen
    if size == 0:
        return
    
    gameboard.boardArray = newSeqWith(size, newSeqWith(size, Cell()))
    forEachIndexed[seq[Cell]](
        gameboard.boardArray,
        proc(row: seq[Cell], y: int) = 
            forEachIndexed[Cell](
                row,
                proc (cell: Cell, x: int) =
                    cell.init(
                        x,
                        y,
                        gameboard.createBreeder(x, y, gameboard.offset)
                    )
            )
    )
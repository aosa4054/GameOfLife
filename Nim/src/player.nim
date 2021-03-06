import gameboard as gb
import cell as cl
import utils
import params
import os

proc printGameboard(gameboard: Gameboard) =
    let boardArr = gameboard.getBoardArray()
    forEachDubleArray[Cell](
        boardArr,
        proc(cell: Cell) = 
            stdout.write cell.getStateMark
            if cell.isOnEnd(gameboard.sideLen):
                echo ""
    )
    echo ""
    echo ""
    echo ""
    sleep(1000)

# 実行処理
when isMainModule:
    
    let gameboard = newGameboard(BOARD_SIZE,BREEDER_OFFSET)
    
    for i in 0..GENERATIONS:
        gameboard.toNextGen
        printGameboard(gameboard)
        
    echo "finished"

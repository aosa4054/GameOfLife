import gameboard as gb
import cell as cl
import utils
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

let gameboard = Gameboard(sideLen: 30, offset: 12)
gameboard.onCreate()
    
for i in 0..30:
    gameboard.toNextGen
    printGameboard(gameboard)

echo "finished"
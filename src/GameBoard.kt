import kotlin.random.Random
import Cell.State

class GameBoard(
    private val sideLength: Int,
    boardMode: String = STYLE_RANDOM
) {
    val board: Array<Array<Cell>>

    init {
        when(boardMode) {
            STYLE_SWITCH -> {
                board = Array(sideLength) { y ->
                    kotlin.Array(sideLength) { x ->
                        val state = createBreederState(x, y, GRAPHIC_OFFSET)
                        Cell(x, y, state)
                    }
                }
            }
            else -> {
                board = Array(sideLength) { y ->
                    kotlin.Array(sideLength) { x ->
                        val r = Random.nextInt() % 8
                        val state = if (r < 2) State.Living else State.Dead
                        Cell(x, y, state)
                    }
                }
            }
        }
    }

    private fun createBreederState(x: Int, y: Int, offset: Int)  =
        when {
            x == 1 + offset && y == 1 + offset -> State.Living
            x == 2 + offset && y == 1 + offset -> State.Living
            x == 3 + offset && y == 1 + offset -> State.Living
            x == 5 + offset && y == 1 + offset -> State.Living
            x == 1 + offset && y == 2 + offset -> State.Living
            x == 1 + offset && y == 1 + offset -> State.Living
            x == 4 + offset && y == 3 + offset -> State.Living
            x == 5 + offset && y == 3 + offset -> State.Living
            x == 2 + offset && y == 4 + offset -> State.Living
            x == 3 + offset && y == 4 + offset -> State.Living
            x == 5 + offset && y == 4 + offset -> State.Living
            x == 1 + offset && y == 5 + offset -> State.Living
            x == 3 + offset && y == 5 + offset -> State.Living
            x == 5 + offset && y == 5 + offset -> State.Living
            else -> State.Dead
        }

    fun simulateGameBoard() {
        board.forEveryElementsInOrder(
            {
                it.prepareSimulate(getAroundCellsOfACell(it))
            },
            {
                it.simulate()
            }
        )
    }

    private fun getAroundCellsOfACell(cell: Cell): List<Cell> {
        return getCellOfRelationalPosition(cell,
            when {
                cell.isOnStart && cell.isOnTop -> listOf(5,7,8)
                cell.isOnStart && cell.isOnBottom -> listOf(2,3,5)
                cell.isOnEnd && cell.isOnTop -> listOf(4,6,7)
                cell.isOnEnd && cell.isOnBottom -> listOf(1,2,4)
                cell.isOnStart -> listOf(2,3,5,7,8)
                cell.isOnEnd -> listOf(1,2,4,6,7)
                cell.isOnTop -> listOf(4,5,6,7,8)
                cell.isOnBottom -> listOf(1,2,3,4,5)
                else -> listOf(1,2,3,4,5,6,7,8)
            }
        )
    }

    /**
     * @param positions
     * |1|2|3|
     * |4|■|5|
     * |6|7|8|
     */
    private fun getCellOfRelationalPosition(cell: Cell, positions: List<Int>): List<Cell> {
        return positions.map {
            when (it) {
                1 -> board[cell.y - 1][cell.x - 1]
                2 -> board[cell.y - 1][cell.x]
                3 -> board[cell.y - 1][cell.x + 1]
                4 -> board[cell.y][cell.x - 1]
                5 -> board[cell.y][cell.x + 1]
                6 -> board[cell.y + 1][cell.x - 1]
                7 -> board[cell.y + 1][cell.x]
                8 -> board[cell.y + 1][cell.x + 1]
                else -> board[cell.y][cell.x]
            }
        }
    }

    private fun <T> Array<Array<T>>.forEveryElementsInOrder(
        function1: (element1: T) -> Unit,
        function2: (element2: T) -> Unit
    ) {
        this.forEveryElements(function1)
        this.forEveryElements(function2)
    }

}


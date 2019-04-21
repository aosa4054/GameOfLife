import Printer.Companion.printError

class Cell(val x: Int, val y: Int, var state: State){

    private lateinit var nextState: State

    val isOnTop = y == 0
    val isOnBottom = y == BOARD_SIZE - 1
    val isOnStart = x == 0
    val isOnEnd = x == BOARD_SIZE - 1

    fun prepareSimulate(aroundCells: List<Cell>) {
        if (aroundCells.size > 8) {
            printError()
            return
        }

        nextState = when (state) {
            State.Living -> when (aroundCells.filter{ it.state == State.Living }.size) {
                2, 3 -> State.Living
                else -> State.Dead
            }
            State.Dead -> when (aroundCells.filter{ it.state == State.Living }.size) {
                3 -> State.Living
                else -> State.Dead
            }
        }
    }

    fun simulate() {
        state = nextState
    }

    enum class State {
        Living {
            override fun getMark() = "■ "
        },
        Dead {
            override fun getMark() = "□ "
        };
        abstract fun getMark(): String
    }
}
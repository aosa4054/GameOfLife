class Printer {
    private fun emptyLines(l: Int) {
        for (i in 0 until l) {
            println()
        }
    }

    fun printGameBoard(board: Array<Array<Cell>>) {
        board.forEveryElements {
            print(it.state.getMark())
            if (it.isOnEnd) println()
        }
        emptyLines(3)
    }

    fun finish() {
        emptyLines(1)
        println("$REPEAT_TIMES generations finished!")
    }

    fun extincted(generation: Int) {
        println("All cells are dead!")
        println("Generation: $generation")
    }

    companion object {
        fun printError() {
            println("Oops, something is wrong!")
        }
    }
}
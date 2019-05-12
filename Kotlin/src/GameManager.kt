class GameManager {
    private val gameBoard = GameBoard(BOARD_SIZE, STYLE_SWITCH)
    private val printer = Printer()

    init {
        play()
    }

    private fun play() {
        printer.printGameBoard(gameBoard.board)
        for (gen in 1 .. REPEAT_TIMES) {
            if (allCellsAreDead()) {
                printer.extincted(gen)
                return
            }
            playOneGeneration()
        }
        printer.finish()
    }

    private fun playOneGeneration() {
        Thread.sleep(1000)
        val boardWithNewState = gameBoard.apply {
            simulateGameBoard()
        }.board
        printer.printGameBoard(boardWithNewState)
    }

    private fun allCellsAreDead() =
            gameBoard.board.all { it.all { cell -> cell.state == Cell.State.Dead } }
}
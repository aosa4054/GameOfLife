const val BOARD_SIZE = 35
const val REPEAT_TIMES = 100
const val GRAPHIC_OFFSET = 12
const val STYLE_RANDOM = "style_random"
const val STYLE_SWITCH = "style_switch"

fun main() {
    GameManager()
}

fun <T> Array<Array<T>>.forEveryElements(function: (element: T) -> Unit) {
    this.forEach { column ->
        column.forEach { element ->
            function(element)
        }
    }
}
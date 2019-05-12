import sequtils

proc forEach*[T](list: seq[T], action: proc(it: T)) =
    for it in list:
        action(it)

proc indexOf*[T](list: seq[T], item: T) : int = 
    var count = 0
    for it in list:
        if it == item:
            return count
        else:
            count = count + 1
    return -1

proc forEachIndexed*[T](list: seq[T], action: proc(it: T, index: int)) =
    for it in list:
        let index = indexOf[T](list, it)
        action(it, index)

proc forEachDubleArray*[T](listlist: seq[seq[T]], action: proc(it: T)) = 
    for list in listlist:
        forEach[T](list, action)
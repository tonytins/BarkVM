enum Instruction {
    case pushNum(Double)
    case pushBool(Bool)
    case pushTrilean(Trilean)
    case pushNone
    case add
    case store(name: String)
    case load(name: String)
    case print
    case ifElse(then: [Instruction], otherwise: [Instruction])
}

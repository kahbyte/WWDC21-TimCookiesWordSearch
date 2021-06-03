
public enum PageType {
    case Tutorial
    case Tutorial2
    case Challenge
    case Custom
    
    var successMessage: String {
        switch self {
        case .Tutorial:
            return "Nice! 🎉 You successfully learned how to capture a word! Come to the [next page](@next). We have cookies!"
        case .Tutorial2:
            return "Wow! You learn so fast 🤯🎉! You are ready for the challenge! Is the cookies rain 🍪 a lie? Discover in the [next page](@next)."
        case .Challenge:
            return "You made it! It's raining cookies 🍪! I'm so proud of you! Wait, what? Too easy? Try the harder difficulties! I hope you enjoyed, but there's one more thing waiting for you in the [next and final page](@next) ❤️"
        case .Custom:
            return "Congratulations you have found all the words! It's raining cookies 🍪"
        }
    }
}

public enum Tone {
    case right
    case wrong
    case victory
    
    var toneName: String {
        switch self {
        case .right:
            return "rightTone"
        case .wrong:
            return "wrongTone"
        case .victory:
            return "victoryTone"
                
        }
    }
}

public enum PlacementType: CaseIterable {
    case leftRight
    case upDown
    case downUp
    case rightLeft
    
    
    var movement: (i: Int, j: Int) {
        switch self {
        case .leftRight:
            return (1,0)
        case  .upDown:
            return (0,1)
        case .downUp:
            return (0,-1)
        case .rightLeft:
            return (-1,0)
        }
    }
}

public enum Difficulty {
    case easy
    case medium
    case hard
    
    var placementTypes: [PlacementType] {
        switch self {
        case .easy:
            return [.leftRight, .upDown].shuffled()
        case .medium:
            return [.leftRight, .upDown, .downUp].shuffled()
        case .hard:
            return [.leftRight, .upDown, .downUp, .rightLeft].shuffled()
            
        default:
            return PlacementType.allCases.shuffled()
        }
    }
}

import UIKit
import SpriteKit
import PlaygroundSupport
import AVFoundation

open class WordHuntGrid: UIView {
    var contentView = UIView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
    var numViewPerRow: Int?
    var cells = [String: Cell]()
    var label = UILabel()
    var pageType: PageType?
    var alphabet: String!
    
    var selectedKeys: [String] = []
    var verifiedKeys: [String] = []
    var selectedWord: String = ""
    var selectedWordAndKey: [(key: String,word: String)] = []
    let skView = SKView()
    var player: AVAudioPlayer?
    
    var wordsToPlace: [String]?
    var wordsToFind: [String]?
    var wordsFound: [String] = []
    var difficulty: Difficulty!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(contentView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(contentView)
    }
    
    open func initGrid() {
        let width = contentView.frame.width / CGFloat(numViewPerRow!)
        
        switch pageType {
        case .Challenge: 
            alphabet = "AAAABBCCEEEFFGGHJJKKLLMMNNOOOQQRRSSTTUUUVWXYZ"
        case .Tutorial:
            alphabet = " "
        case .Tutorial2:
            alphabet = "."
        case .Custom:
            alphabet = "AAAABBCCEEEFFGGHJJKKLLMMNNOOOQQRRSSTTUUUVWXYZ"
        case .none: 
            alphabet = " "
        }
        
        autoreleasepool {
            for j in 1...numViewPerRow! {
                for i in 1...numViewPerRow! {
                    let cell = Cell(x: width * CGFloat(i-1), y: width * CGFloat(j-1), width: width, height: width, alphabet: alphabet)
                    cell.centerLabel()
                    
                    cell.backgroundColor = .white
                    cell.layer.borderColor = #colorLiteral(red: 0.18691053986549377, green: 0.11482758074998856, blue: 0.06516552716493607, alpha: 1.0)
                    cell.layer.borderWidth = 1
                    cell.label.text = "0"
                    
                    contentView.addSubview(cell)
                    let key = "\(i)|\(j)"
                    cells[key] = cell
                }
            }
        }
        
        switch pageType {
        case .Tutorial:
            wordsToFind = placeTutorialWord()
        case .Tutorial2:
            difficulty = .easy
            wordsToFind = placeWords()
        case .Challenge:
            wordsToFind = placeWords()
        case .Custom:
            wordsToFind = placeWords()
        case .none:
            wordsToFind = placeWords()
        }
        
        fillGaps()
    }
    
    
    
    //Usar quando terminar de alocar as palavras
    open func fillGaps() {
        for j in 1...numViewPerRow! {
            for i in 1...numViewPerRow! {
                let key = "\(i)|\(j)"
                cells[key]!.fillGaps()
            }
        }
    }
    
    func endGame() {
        self.isUserInteractionEnabled = false
        for j in 1...numViewPerRow! {
            for i in 1...numViewPerRow! {
                let key = "\(i)|\(j)"
                if !verifiedKeys.contains(key) {
                    UIView.animate(withDuration: 2, animations: { [self] in
                        cells[key]!.backgroundColor = #colorLiteral(red: 0.8406170010566711, green: 0.8407586216926575, blue: 0.8405983448028564, alpha: 1.0)
                    })
                }
            }
        }
        
        initSKScene()
        setupParticles()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.playSound(tone: .victory)
        }
        
        
        PlaygroundPage.current.assessmentStatus = .pass(message: pageType?.successMessage)
    }
    
    open func placeTutorialWord() -> [String] {
        var word = Array(wordsToPlace![0])
        var wordsToFind: [String] = []
        var currentPos = 1
        
        for letter in word {
            let key = "\(currentPos + 1)|4"
            cells[key]?.label.text = "\(letter)"
            currentPos = currentPos + 1
        }
        
        wordsToFind.append(wordsToPlace![0])
        
        return wordsToFind
    }
    
    open func labels(i: Int, j: Int, word: String, movement: (i: Int, j: Int)) -> [String]? {
        var returnKeys = [String]()
        
        var i = i
        var j = j
        
        
        for letter in word {
            let key = "\(i)|\(j)"
            let text = cells[key]?.label.text
            
            if text == "0" {
                returnKeys.append(key)
                i += movement.i
                j += movement.j
            } else {
                return nil
            }
        }
        return returnKeys
    }
    
    open func tryPlacing(_ word: String, movement: (i: Int, j: Int)) -> Bool {
        let iLength = (movement.i * (word.count - 1))
        let jLength = (movement.j * (word.count - 1))
        
        let rows = (0 ..< numViewPerRow!).shuffled()
        let cols = (0 ..< numViewPerRow!).shuffled()
        
        for i in rows {
            for j in cols {
                let finalI = i + iLength
                let finalJ = j + jLength
                
                if finalI >= 0 && finalI <= numViewPerRow! && finalJ >= 0 && finalJ <= numViewPerRow! {
                    if let returnValue = labels(i: i, j: j, word: word, movement: movement) {
                        for (index, letter) in word.enumerated() {
                            cells[returnValue[index]]?.label.text = String(letter)
                        }
                        
                        return true
                    }
                }
            }
        }
        return false
    }
    
    open func place(_ word: String) -> Bool {
        
        
        return difficulty.placementTypes.contains {
            tryPlacing(word, movement: $0.movement)
        }
        
        return false
    }
    
    open func placeWords() -> [String] {
        return wordsToPlace!.shuffled().filter(place)
    }
    
    open func contains(a: [(String, String)], v: (String, String)) -> Bool {
        let (c1,c2) = v
        for (v1, v2) in a { if v1 == c1 && v2 == c2 { return true }}
        return false
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let local = touch.location(in: contentView)
            
            let width = contentView.frame.width / CGFloat(numViewPerRow!)
            
            let i = Int(local.x / width)
            let j = Int(local.y / width)
            
            let key = "\(i + 1)|\(j + 1)"
            
            if !verifiedKeys.contains(key) && i >= 0 && i < numViewPerRow! && j >= 0 && j < numViewPerRow! {
                UIView.animate(withDuration: 0.3, animations: { [self] in
                    cells[key]?.backgroundColor = #colorLiteral(red: 0.9994556308, green: 0.9863594174, blue: 0.2532016337, alpha: 1.0)
                })
                
                if !contains(a: selectedWordAndKey, v: (key, cells[key]!.label.text!)) {
                    selectedWordAndKey.append((key, cells[key]!.label.text!))
                    selectedKeys.append(key)
                    selectedWord += (cells[key]?.label.text)!
                }
            }
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let paintColor = [#colorLiteral(red: 0.8781718612, green: 0.9300099611, blue: 0.8306068778, alpha: 1.0),#colorLiteral(red: 0.9968190789, green: 0.9900643229, blue: 0.866343081, alpha: 1.0),#colorLiteral(red: 0.9443791509, green: 0.7896900177, blue: 0.9972682595, alpha: 1.0),#colorLiteral(red: 0.8491268754, green: 0.7906861305, blue: 0.9974070191, alpha: 1.0),#colorLiteral(red: 1.0364362001419067, green: 0.8012922406196594, blue: 0.8864280581474304, alpha: 1.0), #colorLiteral(red: 0.7936894298, green: 0.9429106116, blue: 0.9972818494, alpha: 1.0), #colorLiteral(red: 0.8781718612, green: 0.9300099611, blue: 0.8306068778, alpha: 1.0), #colorLiteral(red: 1.0, green: 0.9264350533, blue: 0.8336678147, alpha: 1.0), #colorLiteral(red: 0.9714753032, green: 0.9805012345, blue: 0.8598872423, alpha: 1.0)].randomElement()
        let reversedSelectedWord = String(selectedWord.reversed())
        
        for word in wordsToFind! {
            if selectedWord == word || reversedSelectedWord == word {
                for key in selectedKeys {
                    UIView.animate(withDuration: 2, animations: { [self] in
                        cells[key]?.backgroundColor = #colorLiteral(red: 0.0, green: 0.9768045545, blue: 0.0, alpha: 1.0)
                    })
                    UIView.animate(withDuration: 0.8, animations: { [self] in
                        cells[key]?.backgroundColor = paintColor
                    })
                    verifiedKeys.append(key)
                }
                let indexToRemove = wordsToFind!.firstIndex(of: word)!
                wordsFound.append((wordsToFind?.remove(at: indexToRemove))!)
                
                if wordsToFind!.count == 0 {
                    endGame()
                }
                
                
                selectedWordAndKey = []
                selectedWord = ""
                selectedKeys = []
                playSound(tone: .right)
                return
            }
        }
        
        for key in selectedKeys {
            UIView.animate(withDuration: 1, animations: { [self] in
                cells[key]?.backgroundColor = #colorLiteral(red: 1.0, green: 0.3837403059, blue: 0.3160096407, alpha: 1.0)
            })
            UIView.animate(withDuration: 0.8, animations: { [self] in
                cells[key]?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
            })
        }
        
        selectedWordAndKey = []
        selectedWord = ""
        selectedKeys = []
        self.playSound(tone: .wrong)
    }
    
    private func setupParticles() {
        self.addSubview(skView)
    
        
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.allowsTransparency = true
        
        let top = skView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        let leading = skView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        let trailing = skView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        let bottom = skView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
    private func initSKScene() {
        let particleScene = ParticleScene(size: CGSize(width: 1080, height: 1920))
        particleScene.scaleMode = .aspectFill
        
        particleScene.backgroundColor = .clear
        particleScene.setupParticleEmitter()
        
        skView.presentScene(particleScene)
    }
    
    func playSound(tone: Tone) {
        guard let url = Bundle.main.url(forResource: tone.toneName, withExtension: "m4a") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.volume = (tone != .victory ? player.volume * 0.08 : player.volume * 0.2)
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
        
    
}

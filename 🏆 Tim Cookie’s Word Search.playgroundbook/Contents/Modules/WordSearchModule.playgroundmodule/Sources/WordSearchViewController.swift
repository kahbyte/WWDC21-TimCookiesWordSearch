import UIKit
import PlaygroundSupport

open class WordSearchViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    let wordHuntView = WordHuntGrid()
    let wordsLeftButton = UIButton()
    
    open var pageType: PageType?
    open var numberOfViewsPerRow: Int?
    open var words: [String]?
    open var difficulty: Difficulty!
    
    open override func loadView() {
        super.loadView()
        wordHuntView.layer.borderColor = #colorLiteral(red: 0.1868859827518463, green: 0.11501418799161911, blue: 0.06667857617139816, alpha: 1.0)
        wordHuntView.layer.borderWidth = 5
        wordsLeftButton.addTarget(self, action: #selector(showHintsPopover), for: .touchUpInside)
        wordsLeftButton.setImage(UIImage(named: "WordsButton"), for: .normal)
        
        wordsLeftButton.setTitle("Words", for: .normal)
        
        self.view.backgroundColor = #colorLiteral(red: 0.6996833086013794, green: 0.5036570429801941, blue: 0.2567942142486572, alpha: 1.0)
        self.view.addSubview(wordHuntView)
        self.view.addSubview(wordsLeftButton)
        
        wordHuntView.pageType = pageType
        wordHuntView.numViewPerRow = numberOfViewsPerRow
        wordHuntView.wordsToPlace = words
        wordHuntView.difficulty = difficulty
        wordHuntView.initGrid()
        wordHuntView.isUserInteractionEnabled = true
    }
    
    open override func viewDidLayoutSubviews() {
        setHuntViewConstraints()
    }
    
    @objc func showHintsPopover(sender: UIButton!) {
        showTipsPopover()
    }
    
    func setHuntViewConstraints() {
        wordHuntView.translatesAutoresizingMaskIntoConstraints = false
        wordsLeftButton.translatesAutoresizingMaskIntoConstraints = false
        
        wordHuntView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordHuntView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50 * (self.view.frame.height / 1120.0)).isActive = true
        wordHuntView.heightAnchor.constraint(equalToConstant: 800).isActive = true
        wordHuntView.widthAnchor.constraint(equalToConstant:  800).isActive = true
        
        wordsLeftButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordsLeftButton.bottomAnchor.constraint(equalTo: wordHuntView.bottomAnchor, constant: 150).isActive = true
        wordsLeftButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        wordsLeftButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
    }
    
    func showTipsPopover() {
        let hintsPopover = HintsPopover()
        hintsPopover.modalPresentationStyle = .popover
        hintsPopover.preferredContentSize = CGSize(width: 300, height: 350)
        hintsPopover.popoverPresentationController?.permittedArrowDirections = .down
        hintsPopover.popoverPresentationController?.delegate = self
        hintsPopover.popoverPresentationController?.sourceView = self.wordsLeftButton
        hintsPopover.popoverPresentationController?.sourceRect = CGRect(x: self.wordsLeftButton.bounds.midX, y: 0, width: 0, height: 0)
        hintsPopover.hints = wordHuntView.wordsToFind
        
        present(hintsPopover, animated: true, completion: nil)
    }
}


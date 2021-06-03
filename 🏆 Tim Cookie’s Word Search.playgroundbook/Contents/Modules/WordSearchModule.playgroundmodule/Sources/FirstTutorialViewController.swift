
import UIKit
import PlaygroundSupport

open class FirstTutorialViewController: UIViewController {
    let wordHuntView = WordHuntGrid()
    
    open override func loadView() {
        super.loadView()
        print(self.view.frame.size)
        wordHuntView.layer.borderColor = UIColor.lightGray.cgColor
        wordHuntView.layer.borderWidth = 3
        
        self.view.backgroundColor = #colorLiteral(red: 0.6996833086013794, green: 0.5036570429801941, blue: 0.2567942142486572, alpha: 1.0)
        self.view.addSubview(wordHuntView)
        
        wordHuntView.pageType = .Tutorial
        wordHuntView.numViewPerRow = 7
        wordHuntView.wordsToPlace = ["APPLE"]
        wordHuntView.initGrid()
        wordHuntView.isUserInteractionEnabled = true
        
        
    }
    
    open override func viewDidLayoutSubviews() {
        setHuntViewConstraints()
    }
    
    func setHuntViewConstraints() {
        wordHuntView.translatesAutoresizingMaskIntoConstraints = false
        
        wordHuntView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordHuntView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wordHuntView.heightAnchor.constraint(equalToConstant: 800).isActive = true
        wordHuntView.widthAnchor.constraint(equalToConstant:  800).isActive = true
    }
    
}


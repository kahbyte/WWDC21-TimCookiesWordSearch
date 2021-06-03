import UIKit

class Cell: UIView {
    var character: String!
    var width: CGFloat?
    var alphabet: [String]?
    var label = UILabel()
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, alphabet: String?) {
        self.alphabet = Array(arrayLiteral: alphabet?.uppercased() ?? " ")
        self.character = String(alphabet?.randomElement() ?? " ")
        self.width = width
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.character = String(alphabet?.randomElement() ?? " ")
        super.init(coder: aDecoder)
    }
    
    func centerLabel() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.label.text = " "
        self.label.textColor = .black
        self.label.textAlignment =  .center
        self.label.font = self.label.font.withSize(self.frame.width / 2)
        self.label.sizeToFit()
    }
    
    func fillGaps() {
        if self.label.text == "0" {
            self.label.text = character
        }
    }
    
}

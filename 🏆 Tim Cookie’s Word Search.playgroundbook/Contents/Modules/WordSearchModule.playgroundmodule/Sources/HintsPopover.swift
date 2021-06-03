
import UIKit
import PlaygroundSupport

open class HintsPopover: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView = UITableView()
    
    var hints: [String]?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.backgroundColor = #colorLiteral(red: 0.18691053986549377, green: 0.11482758074998856, blue: 0.06516552716493607, alpha: 1.0)
        
        view.addSubview(tableView)
    }
    
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hints!.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "\(hints![indexPath.row])"
        cell.textLabel?.font = cell.textLabel?.font.withSize(30)
        cell.backgroundColor = #colorLiteral(red: 0.1868859827518463, green: 0.11501418799161911, blue: 0.06667857617139816, alpha: 1.0)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.height / CGFloat(hints!.count)) - 3
    }
}

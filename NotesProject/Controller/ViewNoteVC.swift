import UIKit
import RealmSwift

class ViewNoteVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var note: Note?
    var deletionHandler: (() -> Void)?
    let eraser = Eraser()
    
    // to save resources...
    static let dateFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
        
    }() // it is called once
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = note?.text
        dateLabel.text = Self.dateFormatter.string(from: note!.date)
        
        self.navigationItem.rightBarButtonItem =
            
            UIBarButtonItem(
            title: "удалить",
            style: .done,
            target: self,
            action: #selector(deleteNote))
    }
    
    @objc private func deleteNote() {
        
        if let openedNote = self.note {
            
            eraser.delete(openedNote)
            deletionHandler?()
            
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

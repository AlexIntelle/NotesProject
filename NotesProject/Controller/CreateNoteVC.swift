import UIKit
import RealmSwift

class CreateNoteVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    let noteSaver = NoteSaver()
    var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // showing text input right after vc appeared
        textField.becomeFirstResponder()
        textField.delegate = self
        
        // setting current day
        datePicker.setDate(Date(), animated: true)
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.inline
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            
            title: "Сохранить",
            style: .done,
            target: self,
            action: #selector(saveButtonTapped))
    }
    
    // closing keyboard after tapping return
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder(); return true
    }
    
    @objc func saveButtonTapped() {
        
        if let writtenText = textField.text, !writtenText.isEmpty {
            
            let note = Note()
            note.text = writtenText
            
            let date = datePicker.date
            note.date = date
            
            noteSaver.save(note)
            completionHandler?()
            
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

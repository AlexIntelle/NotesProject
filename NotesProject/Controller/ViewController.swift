import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet var table: UITableView!
    
    private let realm = try! Realm()
    private var notes = Array<Note>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // assigning all objects in Realm of type Note to array
        notes = realm.objects(Note.self).map { $0 }
        
        // register cell to use in func further
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // this class is delegate
        table.delegate = self
        
        // this class is dataSource
        table.dataSource = self
    }
    
    @IBAction func addButtonTapped() {
        
        if let vc = storyboard?.instantiateViewController(identifier: "CreateNoteVCIdentifier") as? CreateNoteVC {
            
            // passing func to vc via weak reference
            // vc calls this func when saving note
            vc.completionHandler = { [weak self] in self?.updateTable()}
            
            vc.title = "Новая"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // number of rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }
    
    // creating cell using id, filling it with note's text
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].text
        
        return cell
    }
    
    // user taps an entry in the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // animation
        tableView.deselectRow(at: indexPath, animated: true)
        
        // ViewNoteVC instance
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ViewNoteVCIdentifier") as? ViewNoteVC else {
            return}
        
        // entry on which user tapped passing to vc
        let note = notes[indexPath.row]
        vc.note = note
        
        // passing func to vc via weak reference
        vc.deletionHandler = { [weak self] in self?.updateTable() }
        
        vc.title = note.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateTable () {
        notes = realm.objects(Note.self).map { $0 }
        table.reloadData()
    }
}


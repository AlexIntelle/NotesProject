import UIKit
import RealmSwift

class NoteSaver {
    
    private let realm = try! Realm()
    
    func save(_ note: Note) {
        
        realm.beginWrite()
        realm.add(note)
        try! realm.commitWrite()
    }
}

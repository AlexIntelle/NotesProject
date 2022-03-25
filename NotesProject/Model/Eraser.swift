import UIKit
import RealmSwift

class Eraser {
    
    private let realm = try! Realm()
    
    func delete (_ note: Note) {
        
        realm.beginWrite()
        realm.delete(note)
        try! realm.commitWrite()
    }
}

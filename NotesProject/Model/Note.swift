import UIKit
import RealmSwift

class Note: Object {
   @objc dynamic var text = ""
   @objc dynamic var date = Date()
}

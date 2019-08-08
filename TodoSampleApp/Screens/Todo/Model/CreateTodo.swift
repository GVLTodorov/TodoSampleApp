import UIKit

protocol CreateTodo {
  func create(controller: UIViewController, callback: @escaping (String?) -> ())
}

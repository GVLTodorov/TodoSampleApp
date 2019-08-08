import UIKit

class CreateTodoPresenter: CreateTodo {
  func create(controller: UIViewController, callback: @escaping (String?) -> ()) {
    controller.modalTextAlert(title: .createNewTask, placeholder: .todo) { string in
      callback(string)
    }
  }
}

fileprivate extension String {
  static let createNewTask = NSLocalizedString("Create new task", comment: "")
  static let todo = NSLocalizedString("Todo", comment: "")
}

import UIKit
@testable import TodoSampleApp

class CreateTodoPresenterMock: CreateTodo {
  var taskName: String = ""
  
  func create(controller: UIViewController, callback: @escaping (String?) -> ()) {
    callback(taskName)
  }
}

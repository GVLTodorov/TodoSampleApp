import UIKit

class TodoDelegate: NSObject, UITableViewDelegate {
  
  let todoService: TodoService
  var didSelectItem: ((TodoItem) -> Void)?
  
  init(todoService: TodoService) {
    self.todoService = todoService
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = todoService.items[indexPath.row]
    didSelectItem?(item)
  }
}

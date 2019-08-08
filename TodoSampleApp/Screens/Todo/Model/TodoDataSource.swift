import UIKit

class TodoDataSource: NSObject, UITableViewDataSource {
  
  let todoService: TodoService
  let todoCellPresenter: TodoCellPresenter
  var reloadTable: (() -> Void)?
  
  init(todoService: TodoService, todoCellPresenter: TodoCellPresenter) {
    self.todoService = todoService
    self.todoCellPresenter = todoCellPresenter
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoService.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = TodoItemCell()
    let item = todoService.items[indexPath.row]
    
    cell.didTapStatusButton = { [weak self] in
      self?.todoService.set(status: (item.status == .unfinished) ? ItemStatus.done : ItemStatus.unfinished, for: item.id)
      self?.reloadTable?()
    }
    
    todoCellPresenter.present(model: item, in: cell)
    return cell
  }
}

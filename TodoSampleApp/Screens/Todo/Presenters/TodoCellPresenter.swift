import Foundation

class TodoCellPresenter {
  
  func present(model: TodoItem, in cell: TodoItemCell) {
    cell.taskLabel.attributedText =
      (model.status == .unfinished) ?
      NSMutableAttributedString(string: model.task)
      : model.task.strikeThrough()
    cell.statusButton.setTitle(TaskStatusRepresentation.show(status: model.status), for: .normal)
  }
}

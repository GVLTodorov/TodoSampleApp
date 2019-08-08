import Foundation

protocol TodoService {
  var items: [TodoItem] { get }
  func set(status: ItemStatus, for id: UUID)
  func create(task: String?, done: (() -> Void))
  func delete(item id: UUID)
  func change(task: String, for id: UUID)
}

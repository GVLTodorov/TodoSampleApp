import Foundation

class LocalFileTodoService: TodoService {
  func change(task: String, for id: UUID) {
    if let row = self.items.firstIndex(where: {$0.id == id}) {
      let current = items[row]
      items[row] = TodoItem(id: current.id, task: task, status: current.status)
    }
  }
  
  func delete(item id: UUID) {
    if let row = self.items.firstIndex(where: {$0.id == id}) {
      items.remove(at: row)
    }
  }
  
  func create(task: String?, done: (() -> Void)) {
    if let newTask = task, newTask != "" {
      let todo = TodoItem(id: UUID(), task: newTask, status: .unfinished)
      items.append(todo)
      done()
    }
    
    // TODO: add error handling, tell user that empty task has not been created.
  }
  
  func set(status: ItemStatus, for id: UUID) {
    if let row = self.items.firstIndex(where: {$0.id == id}) {
      let current = items[row]
      items[row] = TodoItem(id: current.id, task: current.task, status: status)
    }
  }
  
  var items: [TodoItem] = []
}

import Foundation

struct TodoItem: Codable {
  let id: UUID
  let task: String
  var status: ItemStatus
}

enum ItemStatus: String, Codable {
  case unfinished
  case done
}

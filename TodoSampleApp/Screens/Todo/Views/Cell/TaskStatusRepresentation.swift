import Foundation

class TaskStatusRepresentation {
  static func show(status: ItemStatus) -> String {
    switch status {
    case .unfinished:
      return "⭕️"
    case .done:
      return "✅"
    }
  }
}

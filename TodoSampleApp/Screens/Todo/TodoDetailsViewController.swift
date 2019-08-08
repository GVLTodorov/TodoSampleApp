import UIKit

class TodoDetailsViewController: UIViewController {
  
  private let todoService: TodoService
  private let item: TodoItem
  var replaceItem = ""
  
  init(item: TodoItem, todoService: TodoService = LocalFileTodoService()) {
    
    self.todoService = todoService
    self.item = item
    super.init(nibName: nil, bundle: nil)
  }
  
  var todoDetailsView: TodoDetailsView! {
    return view as? TodoDetailsView
  }
  
  // MARK: - Lifecycle
  
  override func loadView() {
    view = TodoDetailsView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = item.task
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTodo))
    todoDetailsView.didSaveButton = { [weak self] task in
      self?.saveTodo(task: task)
    }
    todoDetailsView.textField.text = item.task
  }
  
  // MARK: - Actions
  
  @objc func deleteTodo() {
    todoService.delete(item: item.id)
    navigationController?.popViewController(animated: true)
  }
  
  @objc func saveTodo(task: String) {
    todoService.change(task: task, for: item.id)
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: Required initializer
  
  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

fileprivate extension String {
  static let taskDetails = NSLocalizedString("Task details", comment: "")
}

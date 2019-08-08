import UIKit

class TodoViewController: UIViewController {
  
  private let todoService: TodoService
  private let todoDataSource: TodoDataSource
  private let todoDelegate: TodoDelegate
  private let createTodoPresenter: CreateTodo

  init(todoService: TodoService = LocalFileTodoService(),
       todoCellPresenter: TodoCellPresenter = TodoCellPresenter(),
       createTodoPresenter: CreateTodo = CreateTodoPresenter()) {

    self.todoService = todoService
    self.todoDataSource = TodoDataSource(todoService: todoService,
                                         todoCellPresenter: todoCellPresenter)
    self.todoDelegate = TodoDelegate(todoService: todoService)
    self.createTodoPresenter = createTodoPresenter
    
    super.init(nibName: nil, bundle: nil)
  }
  
  var todoListView: TodoListView! {
    return view as? TodoListView
  }
  
  // MARK: - Lifecycle
  
  override func loadView() {
    view = TodoListView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = .todoTitle
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newTodoForm))
    
    todoListView.tableView.dataSource = todoDataSource
    todoListView.tableView.delegate = todoDelegate
    todoDataSource.reloadTable = { [weak self] in
      self?.todoListView.tableView.reloadData()
    }
    todoDelegate.didSelectItem = { [weak self] item in
      self?.todoDetails(item: item)
    }
  }
  
  // TODO: Tableview should be bind to model or refresh with notifications, this is just a quick fix.
  override func viewWillAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.todoListView.tableView.reloadData()
  }
  
  // MARK: - Actions
  
  @objc func newTodoForm() {
    createTodoPresenter.create(controller: self) { [weak self] newItem in
      self?.createTodo(newItem: newItem)
    }
  }
  
  private func createTodo(newItem: String?) {
    todoService.create(task: newItem, done: { [weak self] in
      self?.todoListView.tableView.reloadData()
    })
  }
  
  private func todoDetails(item: TodoItem) {
    navigationController?.pushViewController(
      TodoDetailsViewController(item: item, todoService: todoService), animated: true)
  }
  
  // MARK: Required initializer
  
  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

fileprivate extension String {
  static let todoTitle = NSLocalizedString("Todo list", comment: "")
}

import XCTest
@testable import TodoSampleApp

class TodoViewControllerTest: XCTestCase {

  var sut: TodoViewController!
  
  var todoService: LocalFileTodoService!
  var todoCellPresenter: TodoCellPresenter!
  var createTodoPresenter: CreateTodoPresenterMock!
  
  override func setUp() {
    todoService = LocalFileTodoService()
    todoCellPresenter = TodoCellPresenter()
    createTodoPresenter = CreateTodoPresenterMock()
    
    sut = TodoViewController(todoService: todoService, todoCellPresenter: todoCellPresenter, createTodoPresenter: createTodoPresenter)
  }

  override func tearDown() {
    sut = nil
    todoService = nil
    todoCellPresenter = nil
    createTodoPresenter = nil
  }

  func testCreateNewTask() {
    var tableView: UITableView!
    _ = sut.view
    
    tableView = sut.todoListView.tableView
    
    // Todo list should be empty
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
    
    // Set task name to the presenter mock
    createTodoPresenter.taskName = "Don't forget the groceries"
    
    let button = sut.navigationItem.rightBarButtonItem
    _ = button!.target?.perform(button?.action, with: nil)
    
    // Todo list should have one item
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
    
    let cell = tableView.todoItemCell(atRow: 0)
    XCTAssertEqual(cell?.taskLabel.text, "Don't forget the groceries")
    XCTAssertEqual(cell?.statusButton.currentTitle, TaskStatusRepresentation.show(status: .unfinished))
  }
  
  func testToogleTodoStatus() {
    var tableView: UITableView!
    _ = sut.view
    
    tableView = sut.todoListView.tableView
    todoService.loadSample()
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 3)
    
    // Prepare cells
    let cell = tableView.todoItemCell(atRow: 0)
    let cell1 = tableView.todoItemCell(atRow: 1)
    let cell2 = tableView.todoItemCell(atRow: 2)
    
    // Check current status
    XCTAssertEqual(cell?.statusButton.currentTitle, TaskStatusRepresentation.show(status: .unfinished))
    XCTAssertEqual(cell1?.statusButton.currentTitle, TaskStatusRepresentation.show(status: .done))
    XCTAssertEqual(cell2?.statusButton.currentTitle, TaskStatusRepresentation.show(status: .unfinished))
    
    // Click each todo item
    cell?.statusButton.simulateTap()
    cell1?.statusButton.simulateTap()
    cell2?.statusButton.simulateTap()
    
    // Check if status has changed
    XCTAssertEqual(todoService.items[0].status, ItemStatus.done)
    XCTAssertEqual(todoService.items[1].status, ItemStatus.unfinished)
    XCTAssertEqual(todoService.items[2].status, ItemStatus.done)
  }
}

private extension UITableView {
  func todoItemCell(atRow row: Int) -> TodoItemCell? {
    let cell = dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    return cell as? TodoItemCell
  }
}

private extension LocalFileTodoService {
  func loadSample() {
    let sample = Bundle.main
      .url(forResource: "sample-items", withExtension: "json")
      .flatMap { try? Data(contentsOf: $0) }
      .flatMap { try? JSONDecoder().decode([TodoItem].self, from: $0) }

    items = sample ?? []
  }
}

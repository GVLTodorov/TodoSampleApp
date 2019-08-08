import XCTest
@testable import TodoSampleApp

class TodoDetailsViewControllerTest: XCTestCase {
  
  var sut: TodoDetailsViewController!
  var todoService: LocalFileTodoService!
  let item1 = TodoItem(id: UUID(), task: "Test 1", status: .unfinished)
  let item2 = TodoItem(id: UUID(), task: "Test 2", status: .done)
  
  override func setUp() {
    todoService = LocalFileTodoService()
    todoService.items = [item1, item2]
    
    sut = TodoDetailsViewController(item: item1, todoService: todoService)
  }
  
  override func tearDown() {
    sut = nil
    todoService = nil
  }
  
  func testLoadItem() {
    var todoDetailsView: TodoDetailsView!
    _ = sut.view
    
    todoDetailsView = sut.todoDetailsView
    
    // Check if item is loaded
    XCTAssertEqual(todoDetailsView.textField.text, "Test 1")
  }
  
  func testSaveItem() {
    _ = sut.view
    
    sut.todoDetailsView.textField.text = "New task"
    sut.todoDetailsView.saveButton.simulateTap()
    
    // Check if item has been renamed
    XCTAssertEqual(todoService.items[0].task, "New task")
  }
  
  func testDeleteItem() {
    _ = sut.view
    
    // Check if item is loaded
    XCTAssertEqual(todoService.items.count, 2)
    
    let button = sut.navigationItem.rightBarButtonItem
    _ = button!.target?.perform(button?.action, with: nil)
    
    XCTAssertEqual(todoService.items[0].task, "Test 2")
    XCTAssertEqual(todoService.items.count, 1)
  }
  
}

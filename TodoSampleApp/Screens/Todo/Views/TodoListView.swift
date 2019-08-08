import UIKit

class TodoListView: UIView {
  init() {
    super.init(frame: .zero)
    
    setup()
    addSubviews()
    setupLayout()
  }
  
  // MARK: - Configuration
  
  private func setup() {
    backgroundColor = .white
  }
  
  // MARK: - Subviews
  
  let tableView = Subviews.tableView
  
  private func addSubviews() {
    addSubview(tableView)
  }
  
  private func setupLayout() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    let constraints = [
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  // MARK: - Required initializer
  
  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private enum Subviews {
  
  static let tableViewHeight: CGFloat = 60
  static let tableCellIdentifier = "TodoCell"
  
  static var tableView: UITableView {
    let view = UITableView()
    view.rowHeight = tableViewHeight
    view.tableFooterView = UIView(frame: .zero)
    view.register(TodoItemCell.self, forCellReuseIdentifier: tableCellIdentifier)
    
    return view
  }
}

import UIKit

class TodoItemCell: UITableViewCell {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
    addSubviews()
    setupLayout()
    setupButtonAction()
  }
  
  var didTapStatusButton: (() -> Void)?
  
  // MARK: - Configuration
  
  private func setup() {
    selectionStyle = .none
  }
  
  // MARK: - Resusing
  
  override func prepareForReuse() {
    super.prepareForReuse()
    taskLabel.text = nil
    statusButton.setTitle(TaskStatusRepresentation.show(status: .unfinished), for: .normal)
    didTapStatusButton = nil
  }
  
  // MARK: - Subviews
  
  let taskLabel = Subviews.taskLabel
  let statusButton = Subviews.statusButton
  
  private func addSubviews() {
    [taskLabel, statusButton].forEach {
      contentView.addSubview($0)
    }
  }
  
  private func setupLayout() {
    [taskLabel, statusButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let constraints = [
      statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      statusButton.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
      statusButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
      statusButton.trailingAnchor.constraint(equalTo: taskLabel.leadingAnchor, constant: -10),
      statusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      statusButton.widthAnchor.constraint(equalToConstant: 34),
      statusButton.heightAnchor.constraint(equalToConstant: 34),
      taskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      taskLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
      taskLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
      taskLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  // MARK: - Actions
  
  private func setupButtonAction() {
    statusButton.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
  }
  
  @objc private func didTapOnButton() {
    didTapStatusButton?()
  }
  
  // MARK: - Required init
  
  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private enum Subviews {
  
  static let taskLabelSize: CGFloat = 12
  
  static var taskLabel: UILabel {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: taskLabelSize, weight: .semibold)
    
    return label
  }
  
  static var statusButton: UIButton {
    let button = UIButton(frame: .zero)
    
    return button
  }
}

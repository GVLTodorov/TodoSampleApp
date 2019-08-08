import UIKit

class TodoDetailsView: UIView {
  init() {
    super.init(frame: .zero)
    
    setup()
    addSubviews()
    setupLayout()
    setupActions()
  }
  
  var didSaveButton: ((String) -> Void)?
  
  // MARK: - Configuration
  
  private func setup() {
    backgroundColor = .white
  }
  
  // MARK: - Subviews
  
  let textField = Subviews.textField
  let saveButton = Subviews.saveButton
  
  private func addSubviews() {
    [textField, saveButton].forEach {
      addSubview($0)
    }
  }
  
  private func setupLayout() {
    [textField, saveButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let constraints = [
      textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      textField.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -10),
      saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      saveButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  private func setupActions() {
    saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    if let text = textField.text, text.lengthOfBytes(using: .utf8) == 0 {
      saveButton.isEnabled = false
    }
    else {
      saveButton.isEnabled = true
    }
  }
  
  @objc private func didTapSaveButton() {
    didSaveButton?(textField.text ?? "")
  }
  
  // MARK: - Required initializer
  
  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private enum Subviews {
  
  static let buttonTitle = "Save"
  
  static var textField: UITextField {
    let input = UITextField(frame: .zero)
    input.borderStyle = .roundedRect
    
    return input
  }
  
  static var saveButton: UIButton {
    let button = UIButton(type: .roundedRect)
    button.setTitle(Subviews.buttonTitle, for: .normal)
    
    return button
  }
}

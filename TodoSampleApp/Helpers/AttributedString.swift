import UIKit

// Extension for strike through UILabel
// Source: https://stackoverflow.com/questions/13133014/uilabel-with-text-struck-through
extension String {
  
  /// Apply strike font on text
  func strikeThrough() -> NSAttributedString {
    let attributeString = NSMutableAttributedString(string: self)
    attributeString.addAttribute(
      NSAttributedString.Key.strikethroughStyle,
      value: 1,
      range: NSRange(location: 0, length: attributeString.length))
    
    return attributeString
  }
}

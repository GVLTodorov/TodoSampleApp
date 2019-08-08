import UIKit

class WindowFactory: WindowFactoryProtocol {
  
  init(screenBounds: CGRect) {
    self.screenBounds = screenBounds
  }
  
  func makeKeyWindow(rootViewController: UIViewController) -> UIWindow {
    let window = UIWindow(frame: screenBounds)
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()

    return window
  }

  private let screenBounds: CGRect
}

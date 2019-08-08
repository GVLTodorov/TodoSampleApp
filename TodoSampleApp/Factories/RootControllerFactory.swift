import UIKit

class RootControllerFactory: RootControllerFactoryProtocol {
  func makeRootController() -> UIViewController {
    return UINavigationController(rootViewController: TodoViewController())
  }
}

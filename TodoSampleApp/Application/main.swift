import UIKit

let kAppDelegateClass: AnyClass = NSClassFromString("TodoSampleAppTests.AppDelegateMock") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(kAppDelegateClass))

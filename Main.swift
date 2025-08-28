import UIKit

@main
struct MyMain {
    static func main() {
        UIApplicationMain(
            CommandLine.argc,
            CommandLine.unsafeArgv,
            NSStringFromClass(CustomApplication.self),
            NSStringFromClass(AppDelegate.self)
        )
    }
}
// test

# ![kyoot-root](docs/icon.png) QTRoute

[![Build status](https://build.appcenter.ms/v0.1/apps/73deb936-f18b-48aa-b738-d5f840b4d5d7/branches/master/badge)](https://appcenter.ms)

**QTRoute** /'kyoot•root/ - *n* - Declarative general purpose UI navigation and routing model.

  - human readable composition of complex navigation hierarchies
  - automatic pathfinding between routes
  - asynchronous event-driven visitor pattern compatible with any kind of navigation

<br />

## Getting Started

Quick Overview

  1. Clone the repo, add it as a **submodule**, or use SwiftPM.

  **Using Xcode**

  When importing the library for use in an Xcode project (such as for an iOS app), then you should link it to the the `QTRoute.xcodeproj` Xcode project. Simply set your target dependencies to include `libQTRoute.a` and add it to the linking step under the build phases.

  **Using Swift Package Manager**

  You can import the project using the Swift Package Manager. The built `product` should build and integrate fine with any Swift compatible target. Only caveat is that the unit tests are written in such a way that they depend on the XCTActivity feature of XCTest, and so they currently only run under Xcode. So running `swift test` will result in a failure. If you need to run the unit tests, you will need to do so using Xcode environment on a Mac (which includes xcodebuild). Hopefully some day, SwiftPM will support XCTest activities on other platforms.

  2. Compose a *route plan*:

```
	let plan =
	    QTRoute(id.Root,

	        QTRoute(id.ToDo,
	            QTRoute(id.ToDoDetail,
	                    dependencies: ["toDoId"])),

	        QTRoute(id.Help,
	            QTRoute(id.ContactUs),
	            QTRoute(id.MessageCenter)))

```

  3. Implement your *routables*:

```
    class ContactUsViewController: UIViewController, QTRoutable {
        var routeInput: QTRoutableInput?
        var routeResolver: QTRouteResolving?
    }

```

  4. Implement your custom *resolvers*:

```
	func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput,
	                          completion: @escaping QTRoutableCompletion) {

        (from as? UIViewController)?
            .navigationController?
            .popViewController(animated: true) {
                if let parent = navController.topViewController as? QTRoutable {
                    mergeInputDependencies(target: parent, input: input)
                    completion(parent)
                }}
	}

```

  5. Invoke the *driver*:

```
    var routeDriver: QTRouteDriving?

    @IBAction func dismissAction(_ sender: AnyObject?) {
        routeDriver?.driveParent(from: self, input: nil,
                                 animated: true,
                                 completion: nil)
        }
    }

```


<br />

### [Example App](https://github.com/quickthyme/qtroute-example-ios)

There is another project called, *[qtroute-example-ios](https://github.com/quickthyme/qtroute-example-ios)*, written for iOS that demonstrates how one
might go about using various navigation mechanisms.


<br />

## [Reference Documentation](docs/reference.md)

More details on how to use QTRoute in an application can be found [here](docs/reference).


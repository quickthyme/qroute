# ![kyoot-root](icon.png) QTRoute

**QTRoute** /'kyoot•root/ - *n* - Declarative general purpose application routing and UI navigation model.

## Getting Started

This guide will help you get started with using QTRoute, and assumes you already
know your way around [Xcode](https://developer.apple.com/xcode/) and/or
the [Swift Package Manager](https://swift.org/package-manager/).

<br />

### 1) Install the package

Either add it as a *submodule* (for use with **Xcode**), otherwise use **SwiftPM** ...

<br />

#### Using Xcode

When importing the library for use in an Xcode project (such as for an iOS or OSX app), then the
thing to do is add it as a git *submodule*:
  
```
    mkdir -p submodule/qtroute
    git submodule add https://github.com/quickthyme/qtroute.git submodule/qtroute

```

Next, link the **QTRoute.xcodeproj** as a dependency of your project by dragging it from the Finder
into your open project or workspace.

Once you have the project linked, it's build scheme and products will be selectable from drop-downs
in your Xcode project. Just add `QTRoute` to your target's dependencies and `libQTRoute.a` to the
linking phase, and you're all set!

<br />

#### Using the Swift Package Manager

For non-Xcode folks, QTRoute supports the [Swift Package Manager](https://swift.org/package-manager/).
It works fine in any Swift project on any Swift platform, including OSX and Linux.

Just add the dependency to your `Package.swift` file:

  - Package Name: `QTRoute`
  - Package Url: `https://github.com/quickthyme/qtroute.git`
  - Package version: `1.0.0`

Then just ...

```
    swift build
```
That's it, nothing else to do except start using it.

<br />

### 2) Compose a *route plan*

```
    import QTRoute

    let plan =
        QTRoute(id.Root,

	        QTRoute(id.ToDo,
	            QTRoute(id.ToDoDetail,
	                    dependencies: ["toDoId"])),

	        QTRoute(id.Help,
	            QTRoute(id.ContactUs),
	            QTRoute(id.MessageCenter)))

```

<br />

### 3) Implement your *routables*:

```
    class RoutableViewController: UIViewController, QTRoutable {
        var routeInput: QTRoutableInput?
        var routeResolver: QTRouteResolving?
    }

```

<br />

### 4) Implement your custom *resolvers*:

```
    func resolveRouteToParent(from: QTRoutable,
	                          input: QTRoutableInput,
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

<br />

### 5) Invoke the *driver*:

```
    var routeDriver: QTRouteDriving?

    @IBAction func dismissAction(_ sender: AnyObject?) {
        routeDriver?.driveParent(from: self, input: nil,
                                 animated: true,
                                 completion: nil)
        }
    }

```

# ![kyoot-root](icon.png) QTRoute

[![Build status](https://build.appcenter.ms/v0.1/apps/73deb936-f18b-48aa-b738-d5f840b4d5d7/branches/master/badge)](https://appcenter.ms)

**QTRoute** /'kyoot•root/ - *n* - General purpose UI navigation routing model.

  - human readable composition of complex navigation hierarchies
  - automatic pathfinding between routes
  - asynchronous event-driven visitor pattern compatible with any kind of navigation

<br />

## Getting Started

Quick Overview

  1. Clone the repo or add it as a submodule. Once you have that:

      - The QTRoute project builds the static library
      - The ExampleApp project demonstrates its use

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
                    mergeInputDependencies(target: routable, input: input)
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

### Example App

The project includes an example app called, *ExampleApp*, written for iOS that demonstrates how one
might go about using various navigation mechanisms.

<br />

## Reference Documentation

The essential pieces required in order to implement QTRoute in an application.


### QTRoute

The basic element of any route plan. Each "route" is a data structure that represents a contextual view
or "scene" presented by the application. It can include child routes and run-time dependencies.

<br />

### *QTRoutable* CustomRoutable

This protocol is to be implemented by the view controller (or presenter, etc) for a given route. While one
is not provided for you, the included ExampleApp contains several view controller examples.

**routeResolver: QTRouteResolving** *(Required)*
**routeInput: QTRouteInput** *(Required)*

<br />

### *QTRouteDriving* QTRouteDriver

Drives path navigation and resolver events. The `QTRouteDriver` class (and suitable testing "mock") is provided for you.

**driveParent()**

```
driveParent(from: QTRoutable, input: QTRoutableInput, completion: QTRoutableCompletion?)
```
Commands the `QTRouteDriver` to navigate to the *immediate logical parent* from `QTRoutable`.


**driveSub()**

```
driveSub(QTRouteId, from: QTRoutable, input: QTRoutableInput, completion: QTRoutableCompletion?)
```
Commands the `QTRouteDriver` to navigate to any route in the hierarchy, regardless of location, *as if it were*
an *immediate logical descendant* from the current route. (Essentially a subroutine version of `driveTo`.) Pass
any dependency requirements via the `input` parameter.


**driveTo()**

```
driveTo(QTRouteId, from: QTRoutable, input: QTRoutableInput, completion: QTRoutableCompletion?)
```
Commands the `QTRouteDriver` to navigate to any other route in the hierarchy, regardless of location.
Calling this method will cause the `driver` to follow the nearest path to the destination route, raising the
navigation events along the way to your custom `QTRouteResolving` `resolvers`. Pass any dependency
requirements via the `input` parameter.

<br />

### *QTRouteResolving* CustomResolver

The `resolver` is where you implement the actual navigation within your application by responding
to navigation events triggered by the `QTRouteDriver`. The project includes a general purpose
`QTRouteResolver` which supports composition, or you can build one from scratch. The included
ExampleApp contains several resolver examples that you can use as a template.

**route: QTRoute** *(Required)*

**resolveRouteToChild()** *(Required)*

```
resolveRouteToChild(QTRoute, from: QTRoutable, input: QTRoutableInput, completion: QTRoutableCompletion)
```
The resolver is expected to perform the required steps to navigate to one of its *immediate logical
descendants* matching the given `QTRoute`. If the navigation is successful, the resolver must invoke
the `QTRoutableCompletion` block before exiting. Not invoking the completion handler will abort and
cancel any remaining routing steps.


**resolveRouteToParent()** *(Required)*

```
resolveRouteToParent(from: QTRoutable, input: QTRoutableInput, completion: QTRoutableCompletion)
```
The resolver is expected to perform the required steps to navigate to its *immediate logical parent*. If the
navigation is successful, the resolver must invoke the `QTRoutableCompletion` block before exiting. Not
invoking the completion handler will abort and cancel any remaining routing steps.


**resolveRouteToSelf()** *(Optional)*

```
resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, completion: QTRoutableCompletion)
```
The default implementation ignores the result, but does merge input dependencies and calls the completion
handler passing the current routable, which should be sufficient most of the time. This event will be invoked
in response to a `driveTo` event, whenever the `targetId` matches the `source`. †

You might choose to opt-in to this behavior in situations where you want/need to directly invoke
a "refresh" or "re-route" on the current routable, or in cases where the target Id is uncertain.

If you choose to implement this, then the resolver is expected to perform the required steps to navigate
to *itself*, in whatever which way that may be interpreted. If the navigation is successful, the resolver must
invoke the `QTRoutableCompletion` block before exiting.

**†** While performing a `driveSub()` against *self*, the driver will invoke `resolveRouteToChild()` instead.


**mergeInputDependencies()** *(Optional)*

```
mergeInputDependencies(target: QTRoutable, input: QTRoutableInput)
```
The default implementation merges only those values defined as one of the target route's dependencies.
However, this is not called by default, so your custom `resolver` must invoke it when necessary.

<br />

### QTRoutableInput

```
[String:Any]
```
If a given route has declared any dependencies, you can use the contents of the input parameter to satisfy them.

<br />

### QTRoutableCompletion

```
(QTRoutable?)->()
```
Once any given navigation step completes, call the completion handler, passing the destination *routable*.

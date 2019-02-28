# QTRoute
**QTRoute** /'kyoot•root/ - *n* - Universal routing and pathfinding solution written in Swift.

General purpose UI navigation routing model.

  - human readable composition of complex navigation hierarchies
  - automatic pathfinding between routes
  - asynchronous event-driven visitor pattern compatible with any kind of navigation


## Getting Started

Quick Overview

  1. Import the *QTRoute* folder into your project.
  
  2. Compose a *route plan*:
  
```
	let plan: QTRoute =
	    QTRoute(id.Root,
	        QTRoute(id.ToDo,
	            QTRoute(id.ToDoDetail,
	                    dependencies: ["toDoId"])),
	    QTRoute(id.Help,
	        QTRoute(id.ContactUs),
	        QTRoute(id.MessageCenter)))
```
  
  3. Implement your *routables* and custom *resolvers*:

```
	func resolveRouteToParent(from: QTRoutable, input: QTRouteResolvingInput,
	                          completion: @escaping QTRoutableCompletion) {
	    guard let vc = from as? UIViewController,
	        let navController = vc.navigationController else { return }
	    navController.popViewController(animated: true) {
	        if let parent = navController.topViewController as? QTRoutable {
	            completion(parent)
	        }
	    }
	}
```

### Example App

The project includes an example app called, *ExampleApp*, written for iOS that demonstrates how one might go about using various navigation mechanisms.


## Reference Documentation

The essential pieces required in order to implement QTRoute in an application. 


### QTRoute

The basic element of any route plan. Each "route" is a data structure that represents a contextual view or "scene" presented by the application. It can include child routes and run-time dependencies.



### *QTRoutable* CustomRoutable

This protocol is to be implemented by the view controller (or presenter, etc) for a given route. While one is not provided for you, the included ExampleApp contains several view controller examples.

**route: QTRoute** *(Required)*

**routeResolver: QTRouteResolving** *(Required)*



### *QTRouteDriving* QTRouteDriver

Drives path navigation and resolver events. The `QTRouteDriver` class (and suitable testing "mock") is provided for you.

**driveParent()**

```
driveParent(from: QTRoutable, input: QTRouteResolvingInput, completion: QTRouteDrivingCompletion?)
```
Commands the `QTRouteDriver` to navigate to the *immediate logical parent* from `QTRoutable`.


**driveSub()**

```
driveSub(QTRouteId, from: QTRoutable, input: QTRouteResolvingInput, completion: QTRouteDrivingCompletion?)
```
Commands the `QTRouteDriver` to navigate to any other route in the hierarchy, regardless of location, *as if it were* an *immediate logical descendant* from the current route. (Essentially a subroutine version of `driveTo`.) Pass any dependency requirements via the `input` parameter.


**driveTo()**

```
driveTo(QTRouteId, from: QTRoutable, input: QTRouteResolvingInput, completion: QTRouteDrivingCompletion?)
```
Commands the `QTRouteDriver` to navigate to any other route in the hierarchy, regardless of location. Calling this method will cause the `driver` to follow the nearest path to the destination route, raising the navigation events along the way to your custom `QTRouteResolving` `resolvers`. Pass any dependency requirements via the `input` parameter.



### *QTRouteResolving* CustomResolver

The `resolver` is where you implement the actual navigation within your application by responding to navigation events triggered by the `QTRouteDriver`. While one is not provided for you, the included ExampleApp contains several resolver examples that you can use as a template.

**resolveRouteToChild()** *(Required)*

```
resolveRouteToChild(QTRoute, from: QTRoutable, input: QTRouteResolvingInput, completion: QTRoutableCompletion)
```
The resolver is expected to perform the required steps to navigate to one of its *immediate logical descendants* matching the given `QTRoute`. If the navigation is successful, the resolver must invoke the `QTRoutableCompletion` block before exiting. Not invoking the completion handler will abort and cancel any remaining routing steps.


**resolveRouteToParent()** *(Required)*

```
resolveRouteToParent(from: QTRoutable, input: QTRouteResolvingInput, completion: QTRoutableCompletion)
```
The resolver is expected to perform the required steps to navigate to its *immediate logical parent*. If the navigation is successful, the resolver must invoke the `QTRoutableCompletion` block before exiting. Not invoking the completion handler will abort and cancel any remaining routing steps.


**resolveRouteToSelf()** *(Optional)*

```
resolveRouteToSelf(from: QTRoutable, input: QTRouteResolvingInput, completion: QTRoutableCompletion)
```
The default implementation ignores the result and calls the completion handler passing the current routable, which should be sufficient most of the time. This event will be invoked in response to `driveTo` or `driveSub`, whenever the `targetId` matches the `source`. You might opt-in to this for situations where you want/need to directly invoke a "refresh" or "re-route" on the current routable, or in cases where the target Id is uncertain.

If you choose to implement this, then the resolver is expected to perform the required steps to navigate to *itself*, in whatever which way that may be interpreted. If the navigation is successful, the resolver must invoke the `QTRoutableCompletion` block before exiting.



### QTRouteResolvingInput

```
[String:Any]
```
If a given route has declared any dependencies, you can use the contents of the input parameter to satisfy them. 



### QTRoutableCompletion

```
(QTRoutable?)->()
```
Once any given navigation step completes, call the completion handler, passing the destination *routable*.

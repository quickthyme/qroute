# QTRoute
**QTRoute** /'kyoot•root/ - *n* - Universal routing and pathfinding solution written in Swift.

General purpose UI navigation routing model.

  - human readable composition of complex navigation hierarchies
  - automatic pathfinding between routes
  - asynchronous event-driven visitor pattern compatible with any kind of navigation


## Getting Started

Quick Overview

  1. Import the *QTRoute* folder into your project.
  2. Compose a *route plan*.
  3. Implement your *routables* and custom *resolvers* for the *routes*

### Example App

The project includes an example app called, *ExampleApp*, written for iOS that demonstrates how one might go about using various navigation mechanisms.


## Reference Documentation

A little bit helpful.

### QTRouteDriving

**driveTo**

```
driveParent(from: QTRoutable, completion: QTRouteDrivingCompletion?)
```
Commands the `QTRouteDriver` to navigate to the *immediate logical parent* from `QTRoutable`.

```
driveSub(QTRouteId, from: QTRoutable, completion: QTRouteDrivingCompletion?)
```
Commands the `QTRouteDriver` to navigate to any other route in the hierarchy, regardless of location, *as if it were* an *immediate logical descendant* from the current route. (Essentially a subroutine version of `driveTo`.)


```
driveTo(QTRouteId, from: QTRoutable, completion: QTRouteDrivingCompletion?)
```
Commands the `QTRouteDriver` to navigate to any other route in the hierarchy, regardless of location. Calling this method will cause the `driver` to follow the nearest path to the destination route, raising the navigation events along the way to your custom `QTRouteResolving` `resolvers`.

### QTRouteResolving

**resolveRouteToChild**

```
resolveRouteToChild(QTRoute, from: QTRoutable, completion: QTRoutableCompletion)
```
The resolver is expected to perform the required steps to navigate to one of its *immediate logical descendants* matching the given `QTRoute`. If the navigation is successful, the resolver must invoke the `QTRoutableCompletion` block before exiting. Not invoking the completion handler will abort and cancel any remaining routing steps.

**resolveRouteToParent**

```
resolveRouteToParent(from: QTRoutable, completion: QTRoutableCompletion)
```
The resolver is expected to perform the required steps to navigate to its *immediate logical parent*. If the navigation is successful, the resolver must invoke the `QTRoutableCompletion` block before exiting. Not invoking the completion handler will abort and cancel any remaining routing steps.


**resolveRouteToSelf** *(Optional)*

```
resolveRouteToSelf(from: QTRoutable, completion: QTRoutableCompletion)
```
The default implementation of this resolution simply calls the completion handler with `self`. For most purposes, this is probably sufficient. Although, there are some use cases where this can be useful to have.

If you choose to implement this, then the resolver is expected to perform the required steps to navigate to *itself*, however which way that may be interpreted. If the navigation is successful, the resolver must invoke the `QTRoutableCompletion` block before exiting. Not invoking the completion handler will abort and cancel any remaining routing steps.


### QTRoutableCompletion

```
(QTRoutable?)->()
```
Once any given navigation step completes, call the completion handler, passing the destination *routable*.

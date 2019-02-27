# QTroute
**QTroute** /'kyoot•root/ *n* - Universal routing and pathfinding solution written in Swift.

Initially intended for use as a general purpose UI routing model, but technically not limited to that.

  - human readable composition of complex navigation hierarchies
  - automatic pathfinding between routes
  - asynchronous event-driven visitor pattern compatible with any kind of navigation

---
## Getting Started

Quick Overview

  1. Import the *QTRoute* folder into your project.
  2. Compose a *route plan*.
  3. Implement your *routables* and custom *resolvers* for the *routes*

### Example App

The project includes an example app called, *ExampleApp*, written for iOS that demonstrates how one might go about using various navigation mechanisms.

---
## Reference Documentation

#### QTRoutableCompletion
```
(QTRoutable?)->()
```
Once any given navigation step completes, call the completion handler, passing the destination *routable*.

#### QTRouteResolving
```
resolveRouteToChild(_ route: QTRoute, from: QTRoutable, completion: QTRoutableCompletion)
```
The resolver is expected to perform the required steps to navigate to one of its immediate descendants matching the given `QTRoute`. If the navigation is successful, the resolver must invoke the `QTRoutableCompletion` block before exiting. Not invoking the completion handler will abort and cancel any remaining routing steps.

```
resolveRouteToParent(from: QTRoutable, completion: QTRoutableCompletion)
```
The resolver is expected to perform the required steps to navigate to its immediate logical parent. If the navigation is successful, the resolver must invoke the `QTRoutableCompletion` block before exiting. Not invoking the completion handler will abort and cancel any remaining routing steps.



```
resolveRouteToSelf(from: QTRoutable, completion: QTRoutableCompletion)
```
*Optional* - The default implementation of this resolution simply calls the completion handler with `self`.

For most purposes, this is probably sufficient. Although, there are some use cases where this can be useful to have.

If you choose to implement this, then the resolver is expected to perform the required steps to navigate to itself, however which way that may be interpreted. If the navigation is successful, the resolver must invoke the `QTRoutableCompletion` block before exiting. Not invoking the completion handler will abort and cancel any remaining routing steps.

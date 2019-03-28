# ![qroute](icon.png) QRoute

**QRoute** /'kyoo•root/ - *n* - Declarative *walking* router for UI navigation.

## Reference Documentation

The essential pieces required in order to implement QRoute in an application.

<br />

### QRoute

The basic element of any route plan. Each "route" is a data structure that represents a contextual view
or "scene" presented by the application. It can include child routes and run-time dependencies.

<br />

### *QRoutable* CustomRoutable

This protocol is to be implemented by the view controller (or presenter, etc) for a given route. While one
is not provided for you, the included ExampleApp contains several view controller examples.

 - **routeResolver: QRouteResolving** *(Required)*
 - **routeInput: QRouteInput** *(Required)*

<br />

### *QRouteDriving* QRouteDriver

Drives path navigation and resolver events. The `QRouteDriver` class (and suitable testing "mock") is
provided for you.

<br />

**driveParent()**

```
driveParent(from: QRoutable,
            input: QRoutableInput,
            animated: Bool,
            completion: QRoutableCompletion?)
```

Commands the `QRouteDriver` to navigate to the *immediate logical parent* from `QRoutable`.

<br />

**driveSub()**

```
driveSub(QRouteId,
         from: QRoutable,
         input: QRoutableInput,
         animated: Bool,
         completion: QRoutableCompletion?)
```
Commands the `QRouteDriver` to navigate to any route in the hierarchy, regardless of location,
*as if it were* an *immediate logical descendant* from the current route. (Essentially a subroutine
version of `driveTo`.) Pass any dependency requirements via the `input` parameter.

**NOTE**: This works by cloning the target route (and its children) and then binding the clone's
parent to the current route. Once you navigate back, the cloned sub-tree will no longer exist.
This allows you to do many fun and *dangerous* things. For instance, you can stack the same
series of routables indefinitely like in a menu-driven app, or drive global modals. But you can
also create routes that would be irrational if you're not careful.

<br />

**driveTo()**

```
driveTo(QRouteId,
        from: QRoutable,
        input: QRoutableInput,
        animated: Bool,
        completion: QRoutableCompletion?)
```
Commands the `QRouteDriver` to navigate to any other route in the hierarchy, regardless of location.
Calling this method will cause the `driver` to follow the nearest path to the destination route, raising the
navigation events along the way to your custom `QRouteResolving` `resolvers`. Pass any dependency
requirements via the `input` parameter.

<br />

### *QRouteResolving* QRouteResolver

The `resolver` is where you implement the actual navigation within your application by responding
to navigation events triggered by the `QRouteDriver`. Navigation events are *always scheduled on the
main thread*.

Generally, you should just use the provided `QRouteResolver` which supports composition, and likely
suitable for most needs. You *can* create a subclass if necessary, but using composition is generally
a better way to go and therefore encouraged. (I mean this *is* a declarative router, after all.)

The [Example App](https://github.com/quickthyme/qroute-example-ios) contains several resolver
examples that you can use as a starting template.

 - **route: QRoute** *(Required)*

<br />

**resolveRouteToChild()** *(Required)*

```
resolveRouteToChild(QRoute,
                    from: QRoutable,
                    input: QRoutableInput,
                    animated: Bool,
                    completion: QRoutableCompletion)
```
The resolver is expected to perform the required steps to navigate to one of its *immediate logical
descendants* matching the given `QRoute`. If the navigation is successful, the resolver must invoke
the `QRoutableCompletion` block before exiting. Not invoking the completion handler will abort and
cancel any remaining routing steps.

<br />

**resolveRouteToParent()** *(Required)*

```
resolveRouteToParent(from: QRoutable,
                     input: QRoutableInput,
                     animated: Bool,
                     completion: QRoutableCompletion)
```
The resolver is expected to perform the required steps to navigate to its *immediate logical parent*. If the
navigation is successful, the resolver must invoke the `QRoutableCompletion` block before exiting. Not
invoking the completion handler will abort and cancel any remaining routing steps.

<br />

**resolveRouteToSelf()** *(Optional)*

```
resolveRouteToSelf(from: QRoutable,
                   input: QRoutableInput,
                   animated: Bool,
                   completion: QRoutableCompletion)
```
The default implementation ignores the result, but does merge input dependencies and calls the completion
handler passing the current routable, which should be sufficient most of the time. This event will be invoked
in response to a `driveTo` event, whenever the `targetId` matches the `source`. †

You might choose to opt-in to this behavior in situations where you want/need to directly invoke
a "refresh" or "re-route" on the current routable, or in cases where the target Id is uncertain.

If you choose to implement this, then the resolver is expected to perform the required steps to navigate
to *itself*, in whatever which way that may be interpreted. If the navigation is successful, the resolver must
invoke the `QRoutableCompletion` block before exiting.

**†** While performing a `driveSub()` against *self*, the driver will invoke `resolveRouteToChild()` instead.

<br />

**mergeInputDependencies()** *(Optional)*

```
mergeInputDependencies(target: QRoutable,
                       input: QRoutableInput)
```
The default implementation merges only those values defined as one of the target route's dependencies.
However, this is not called by default, so your custom `resolver` must invoke it when necessary.

<br />

### QRoutableInput

```
[String:Any]
```
If a given route has declared any dependencies, you can use the contents of the input parameter to satisfy them.

<br />

### QRoutableCompletion

```
(QRoutable?)->()
```
Once any given navigation step completes, call the completion handler, passing the destination *routable*.

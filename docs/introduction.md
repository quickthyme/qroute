# ![qroute](icon.png) QRoute

**QRoute** /'kyoo•root/ - *n* - Declarative general purpose application routing and UI navigation model.

## Introduction

Here is an introduction to the [QRoute](https://github.com/quickthyme/qroute) library, and
what it does. It assumes that you already have a basic understanding of Swift. Although,
knowledge of Xcode or any other IDE will be irrelevant to the topics covered here.

At a high level, the features provided are:

- human readable composition of complex navigation hierarchies
- automatic pathfinding between routes
- declarative, test-friendly solution for driving view navigation
- compatible with any kind of navigation
- mediation of input dependencies

Before we answer to these bullet points, let's first go over what the actual problem
is that we're trying to solve.

<br />

### The Navigation Imperative

User-interfacing apps are absolutely wrought with side-effects. Most of them are intentional,
however view code is notoriously noisy and difficult to test. The code is entirely compromised;
chock-full of frameworks and cosmetic work-arounds.

Regardless of the business logic in our applications, whether it's a user pressing buttons or
a machine sending tokens, we ultimately have to interface with something outside of our domain
of control. Therefore, at some point we have to write the code that interfaces with the boundary,
and deal with the rules that interfere with our directives and try to manipulate our plan.

A natural part of providing an interactive experience for the user involves the concept of
navigating through different "scenes" within our application. In this way, we are providing a
presence of state, remembering where the user left off and how to respond to their desire to
change the state in whatever way they deem fit. Applications implement this "user browsing state"
in different ways. Some provide windows and nested views, whereas others may be purely auditory
for example. And while the implementations are themselves variable, the need for a declarative
routing solution is constant.

<br />

### The Declarative Router

For those already familiar with functional reactive paradigms, emitters, streams, and reducers,
things should already seem familiar.

But thankfully, even for the rest of us, QRoute is fairly
straight-forward and easy to understand. It is not nearly so complicated as all that and anyone
familiar with the basic visitor pattern should feel comfortable enough.

The basic premise behind QRoute is to have it manage the routing and navigation
on your application's behalf. All you have to do is tell it where you want to
go, and then it goes about the business of navigating to the destination and driving
whatever state changes are required in order to get there.

What QRoute does not do, is provide any sort of UI implementation. That is to say, the way
you go about implementing the specifics of your platform's navigation framework is entirely
dependent on you, your app's designers, and your platform. However, when you render these
specifics becomes coordinated by the QRoute driver.

Essentially, your custom `QRouteResolving` resolvers will be designed to automatically
*react* to general, or in many cases specific, navigation state changes.

**How it works, in a nut-shell**:

  1. Some sort of event triggers `driveTo("somewhere")` on a `QRouteDriver` instance.
  2. The `driver` consults the `route` plan to determine the path it needs to take.
  3. The `driver` invokes the routable's `resolver` with a navigation event to
     one of its `nearest neighbors`.
  4. The `resolver` performs the "navigation", during which time it:
     - should re-render the browser navigation state as appropriate
     - optionally call `mergeDependencies()` against the target's `routeInput` variable
     - should invoke the completion handler when finished (on success)
  5. Then repeats from [step 3] until the navigation path is fully exhausted, at which
     time the optional (final success) completion handler gets invoked.

<br />

### Easy, Reliable Testing

When testing our view code, we tend to put a lot of faith in humble objects, which leads many
folks into implementing integration tests in places where they could be writing cleaner,
less-fragile unit tests.

The way QRoute solves declarative routing, we no longer have to litter up our views with
navigation helpers, spin up waiters, or write clumsy mocks. (We may still have to deal
with those things when it comes to testing our resolvers, but given the likelihood of
reusability, we should come out well ahead.) Most of the time, it will be sufficient to
simply test the state of the injections and verify that the appropriate calls are made.
Furthermore, both QRoute and the corresponding QRoute ExampleApp include convenient,
ready-to-go test doubles which can come in handy for when testing your own resolvers and
other such interactions.

To better see this in action, please refer to the iOS example app located [here](https://github.com/quickthyme/qroute-example-ios).


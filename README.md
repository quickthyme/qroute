# ![qroute](docs/icon.png) QRoute

![release_version](https://img.shields.io/github/tag/quickthyme/qroute.svg?label=release)
[![build status](https://travis-ci.org/quickthyme/qroute.svg?branch=master)](https://travis-ci.org/quickthyme/qroute)
[![swiftpm_compatible](https://img.shields.io/badge/swift_pm-compatible-brightgreen.svg?style=flat) ](https://swift.org/package-manager/)
![license](https://img.shields.io/github/license/quickthyme/qroute.svg?color=black)

**QRoute** /'kyoo•root/ - *n* - Declarative *walking* router for UI navigation.

  - human readable composition of complex navigation hierarchies
  - automatic pathfinding between routes
  - declarative, test-friendly solution for driving view navigation
  - compatible with any kind of navigation
  - mediation of input dependencies

The QRoute walking router is specifically designed to handle situations where you have
a hierarchical arrangement of scenes, pages, windows, or views, and you need a clean,
declarative way in which to define, orchestrate, and drive sweeping, multi-step
navigation routines.

QRoute will determine the nearest path and then `drive` your custom `resolvers`
*(the components that integrate with your particular UI navigation framework)*,
asynchronously invoking them in the correct order, until finally arriving at the
destination.


<br />

## [Introduction](docs/introduction.md)

An [introduction](docs/introduction.md) to the library and what it does.



## [Getting Started](docs/getting-started.md)

Install and start building right away using this quick-start [overview](docs/getting-started.md).



## [Reference Documentation](docs/reference.md)

More details on how to use QRoute in an application can be found [here](docs/reference).



## [Example App](https://github.com/quickthyme/qroute-example-ios)

There is an example app *[qroute-example-ios](https://github.com/quickthyme/qroute-example-ios)*,
written for iOS that demonstrates how one might go about using various navigation mechanisms.


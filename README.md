# SwiftDI
[![Travis CI](https://travis-ci.org/achernoprudov/SwiftDI.svg?branch=master)](https://travis-ci.org/achernoprudov/SwiftDI)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/SwiftDI.svg?style=flat)](http://cocoapods.org/pods/SwiftDI)
[![License](https://img.shields.io/cocoapods/l/SwiftDI.svg?style=flat)](http://cocoapods.org/pods/SwiftDI)
[![Platforms](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-lightgrey.svg)](http://cocoapods.org/pods/SwiftDI)
[![Swift Version](https://img.shields.io/badge/Swift-2.2--3.1.x-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)


Simple dependency injection library for swift projects.

# Example

## Assemble dependencies
Basically `SwiftDI` works as [Service locator](https://en.wikipedia.org/wiki/Service_locator_pattern). It stores
all dependencies inside own list. But `Injector` can be easily splited into submodules to reduce code linking.

```swift
// Swift
let injector = Injector()

injector.bind(ApiProtocol.self)
    .with { _ -> ApiProtocol in 
        // lazy dependency creation block
        return RestApi()
    }

injector.bind(RepositoryProtocol.self)
    .with { injector -> RepositoryProtocol.self in
        // injector could be used to resolve low level dependencies
        let api = injector.resolve(ApiProtocol.self)
        return Repository(api: api) 
    }
```
## Inject dependencies to ViewController directly
```swift
// Swift
class Controller: UIViewController {

  var injector: Injector! = ... // provide injector to VC
  var repository: RepositoryProtocol!

  func viewDidLoad() {
      super.viewDidLoad()
      repository = injector.resolve()
  }
}
```
## Dependency injection options
```swift
// Swift
injector.bind(ApiProtocol.self) // link with type
    .tag("some tag")            // link with custom string tag
    .singleton(true)            // define dependency as singleton
    .with { ... }               // initilization dependency closure
    
injector.resolve(ApiProtocol.self, tag: "some value") //resolving by type and tag 
```

## Submodules
`Injector` support modularization and could have isollated submodules that know about parent but don't know about siblings.

```swift
// Top level module
let injector = Injector()

injector.bind(RepositoryProtocol.self)
    .with { injector -> RepositoryProtocol.self in
         return Repository()
    }

// Screen module
let childInjector = injector.plus()
childInjector.bind(PresenterProtocol.self)
    .with { injector -> PresenterProtocol in 
        return Presenter(repository: injector.resolve())
    }

```

# CocoaPods
[CocoaPods](https://cocoapods.org/) is a dependency manager for Swift and Objective-C Cocoa projects. For setup you have to visit their website.
Once you have set up your project for CocoaPods you can specify `SwiftDI` dependency in your `Podfile`:  

```
pod 'SwiftDI', '~> 1.0'
```

# Swift Package Manager
The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Once you have your Swift package set up, adding `SwiftDI` as a dependency is as easy as adding it to the dependencies value of your `Package.swift`:

### Swift 5
```
dependencies: [
    .package(url: "https://github.com/achernoprudov/SwiftDI.git", from: "1.0.3")
]
```

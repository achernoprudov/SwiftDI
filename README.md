# SwiftDI
[![Travis CI](https://travis-ci.org/achernoprudov/SwiftDI.svg?branch=master)](https://travis-ci.org/achernoprudov/SwiftDI)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/SwiftDI.svg?style=flat)](http://cocoapods.org/pods/SwiftDI)
[![License](https://img.shields.io/cocoapods/l/SwiftDI.svg?style=flat)](http://cocoapods.org/pods/SwiftDI)
[![Platforms](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-lightgrey.svg)](http://cocoapods.org/pods/SwiftDI)
[![Swift Version](https://img.shields.io/badge/Swift-2.2--3.1.x-F16D39.svg?style=flat)](https://developer.apple.com/swift)


Simple dependency injection library for swift projects.

# Example

## Assemble dependencies

```swift
// Swift
let injector = Injector()

injector.bind(ApiProtocol.self).with { _ in 
  return RestApi()
}
injector.bind(RepositoryProtocol.self).with { i in
  let api = i.resolve(ApiProtocol.self)
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

# CocoaPods
```
pod 'SwiftDI', '~> 1.0'
```

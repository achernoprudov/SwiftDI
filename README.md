# SwiftDI
Simple dependency injection library for swift projects.

# Example

## Assemble dependencies

```
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
```
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
```
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

# SwiftDI
Simple dependency injection library for swift projects

# Example

## Assemble dependencies

```
let injector = Injector()

injector.bind(ApiProtocol.self).with { _ in 
  return RestApi()
}
injector.bind(RepositoryProtocol.self).with { i in 
  return Repository(api: i.resolve(ApiProtocol.self)) 
}
```
## Inject dependencies to ViewController
```
class Controller: UIViewController {

  var injector: Injector!
  var repository: RepositoryProtocol!

  func viewDidLoad() {
    super.viewDidLoad()
    repository = injector.resolve(RepositoryProtocol.self)
  }
}
```

# CocoaPods
```
pod 'SwiftDI', '~> 1.0'
```

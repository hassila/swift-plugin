# SwiftPlugin
The minimal API surface required for the Swift Plugin Manager to create instances from a loaded plugin.

Additional documentation and references to sample implementations can be found at the [Plugin Manger GitHub page](https://github.com/hassila/swift-plugin-manager).

### Getting started

Each plug-in type should implement a plugin factory class used for plugin creation in its plugin-api, thus:
```swift
import Plugin

public final class PluginExampleAPIFactory : PluginFactory { // rename the class after the API
  public typealias FactoryType = PluginExampleAPI // update this to the specific API implemented

  fileprivate let _pluginType: FactoryType.Type
    
  public init(_ pluginType: FactoryType.Type) {
    self._pluginType = pluginType
  }

  public func create() -> FactoryType {
    return _pluginType.init()
  }
}
```

additionally, the concrete plugin of a given plugin api type should implement a loader with this specific signature that returns an instances of that factory class thus:

```swift
import PluginExampleAPI

@_cdecl("_pluginFactory")
public func _pluginFactory() -> UnsafeMutableRawPointer {
  return Unmanaged.passRetained(PluginExampleAPIFactory(PluginExample.self)).toOpaque()
}
```

#### Adding the dependency

`SwiftPlugin` is designed for Swift 5.5 and later and works on both macOS 12+ and Linux. To depend on the package to define and implement a plugin API that can be used with the SwiftPluginManager and SwiftPlugin users, you need to declare your dependency in your `Package.swift`:

```swift
.package(url: "https://github.com/hassila/swift-plugin.git", from: "0.0.0"),
```

and to your library target, add `"Plugin"` to your `dependencies`, e.g. like this:

```swift
// Target for Swift 5.5
.target(name: "MyPluginInterface", dependencies: [
    .product(name: "Plugin", package: "swift-plugin")
],
```

//===----------------------------------------------------------------------===//
//
// This source file is part of the Plugin open source project
//
// Copyright (c) 2021 Joakim Hassila and the Plugin project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for a list of project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

/// Plugin factory classes implemented in a Plugin API protocol module must conform to this protocol
/// It supports creation of the specific type supported for a given plugin type (struct/actor/class/enum) and
/// provides a compatibility checking function
public protocol PluginFactory : AnyObject {
  associatedtype FactoryType 

  func create() -> FactoryType
  func compatible(withType: AnyObject.Type) -> Bool
}

// swift package diagnose-api-breaking-changes should be integrated for both client and hosting
// api:s and autogenerate checks for api compatibility validation in the future, right now
// we just check that the factory class is of the expected type
public extension PluginFactory {
  func compatible(withType: AnyObject.Type) -> Bool
  {
    // Can't figure out proper way to do type checking or if it is even possible, Swift seems to
    // view the types as different when built in two different modules?! But this approach works for now
    if String.init(describing: withType) == String.init(describing: Self.self) {
      return true
    }
    return false
  }
}

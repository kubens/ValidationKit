//
//  Optional+AnyOptional.swift
//  ValidationKit
//
//  Created by kubens.com on 06/12/2024.
//

/// A protocol that provides a standardized way to check if an Optional value is `nil`.
///
/// `AnyOptional` allows for type-erased interactions with Optional types by exposing a common property
/// to determine the presence or absence of a value. This can be particularly useful in generic programming
/// scenarios where the specific type of the Optional is not known at compile time.
public protocol AnyOptional {

  /// Indicates whether the optional is `nil`.
  ///
  /// - Returns: `true` if the optional contains `nil`, otherwise `false`.
  var isNil: Bool { get }
}

/// Extends Swift's built-in `Optional` type to conform to the `AnyOptional` protocol.
///
/// This extension allows all `Optional` types in Swift to utilize the `isNil` property,
/// providing a unified interface for checking the presence of a value.
extension Optional: AnyOptional {

  /// Returns `true` if the optional is `nil`, otherwise `false`.
  public var isNil: Bool {
    return self == nil
  }
}

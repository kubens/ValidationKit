//
//  ValidationResult.swift
//  KBValidation
//
//  Created by kubens.com on 01/12/2024.
//

/// Represents the result of validating a specific property of an object.
///
/// This structure holds the `KeyPath` to the validated property and the result
/// of applying a validation rule to that property. It provides a way to track
/// which property was validated and the outcome of the validation.
///
/// - Parameters:
///   - Object: The type of the object containing the property.
///   - Value: The type of the property's value being validated.
public struct ValidationResult: Sendable, CustomStringConvertible {

  /// The key path pointing to the validated property.
  public let keyPath: AnyKeyPath & Sendable

  /// The result of the validation operation.
  public let result: any ValidatorResult

  /// Provides a textual representation of the validation result.
  public var description: String {
    switch result.isFailure {
    case true: "Property \(keyPath) is invalid, \(result.description)"
    case false: "Property \(keyPath) is valid, \(result.description)"
    }
  }

  /// Initializes a new `ValidationResult` for a specific property.
  ///
  /// - Parameters:
  ///   - keyPath: A `KeyPath` pointing to the property that was validated.
  ///   - result: The result of the validation operation for the property.
  internal init(_ keyPath: AnyKeyPath & Sendable, result: any ValidatorResult) {
    self.keyPath = keyPath
    self.result = result
  }
}

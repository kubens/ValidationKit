//
//  ValidationRule.swift
//  KBValidation
//
//  Created by kubens.com on 01/12/2024.
//

import Foundation

/// A validation rule that associates a specific property with a validation logic.
///
/// - Parameters:
///   - Object: The type of the object containing the property.
///   - Value: The type of the property's value.
public struct ValidationRule<Object, Value>: Sendable where Object: Sendable, Value: Sendable {

  /// The key path pointing to the property to be validated.
  public let keyPath: KeyPath<Object, Value> & Sendable

  /// The validator that defines the validation logic for the property's value.
  public let validator: Validator<Value>

  /// Initializes a new validation rule for a property.
  ///
  /// - Parameters:
  ///   - keyPath: A `KeyPath` pointing to the property to validate.
  ///   - validator: A `Validator` that contains the validation logic.
  public init(_ keyPath: KeyPath<Object, Value> & Sendable, validator: Validator<Value>) {
    self.keyPath = keyPath
    self.validator = validator
  }

  /// Validates the value of the property specified by the key path.
  ///
  /// This method retrieves the value of the property from the given object using the `KeyPath`,
  /// and applies the validation logic defined by the `Validator` to that value.
  ///
  /// - Parameter object: The object containing the property to validate.
  /// - Returns: A `ValidationResult` indicating whether the validation succeeded or failed.
  public func validate(_ object: Object) -> ValidationResult {
    let value = object[keyPath: keyPath]
    let result = validator.validate(value)

    return ValidationResult(keyPath, result: result)
  }
}

//
//  AnyValidationRule.swift
//  KBValidation
//
//  Created by kubens.com on 01/12/2024.
//

import Foundation

/// A generic validation rule that enables dynamic validation of objects.
///
/// `AnyValidationRule` serves as a type-erased wrapper for specific ``ValidationRule`` instances,
/// allowing for flexible and dynamic validation logic. This is particularly useful when dealing
/// with collections of validation rules or when the specific types of properties to validate are not known at compile time.
public struct AnyValidationRule<Object>: Sendable where Object: Sendable {

  /// The key path identifying the property of the object to validate.
  ///
  /// This `AnyKeyPath` allows the validation rule to reference any property of the object,
  /// regardless of its type. The `Sendable` conformance ensures that the key path can be safely
  /// used in concurrent contexts.
  public let keyPath: AnyKeyPath & Sendable

  /// A closure that encapsulates the validation logic for an object.
  private let _validate: @Sendable (Object) -> ValidationResult

  /// Creates an `AnyValidationRule` by wrapping a specific `ValidationRule`.
  ///
  /// - Parameter rule: A `ValidationRule` for a specific property of the object.
  public init<Value>(_ rule: ValidationRule<Object, Value>) {
    self.keyPath = rule.keyPath
    self._validate = { rule.validate($0) }
  }

  /// Validates the given object using the encapsulated validation logic.
  ///
  /// - Parameter object: The object to validate.
  /// - Returns: A `ValidationResult` indicating whether the validation succeeded or failed.
  public func validate(_ object: Object) -> ValidationResult {
    return _validate(object)
  }
}

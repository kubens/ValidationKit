//
//  Validations.swift
//  KBValidation
//
//  Created by kubens.com on 01/12/2024.
//

import Foundation

/// A collection of validation rules for a specific object type.
///
/// `Validations` allows you to define and execute validation rules for various
/// properties of an object. It aggregates multiple rules and applies them to
/// an object to ensure it satisfies the required constraints.
///
/// - Parameter Object: The type of the object being validated.
public struct Validations<Object> where Object: Sendable {

  /// The storage of validation rules.
  public var rules: [AnyValidationRule<Object>]

  /// Adds a validation rule for a specific property of the object.
  ///
  /// - Parameters:
  ///   - keyPath: A `KeyPath` pointing to the property to validate.
  ///   - validator: A `Validator` defining the validation logic for the property.
  mutating public func add<Value>(_ keyPath: KeyPath<Object, Value> & Sendable, is validator: Validator<Value>) {
    let rule = ValidationRule(keyPath, validator: validator)
    rules.append(AnyValidationRule(rule))
  }

  /// Validates the given object against all defined validation rules.
  ///
  /// This method iterates through all added validation rules, applies each
  /// validator to the corresponding property of the object, and collects
  /// any validation failures. If one or more validations fail, a `ValidationError`
  /// containing all failure details is thrown.
  ///
  /// - Parameter object: The instance of `Object` to validate.
  /// - Throws: A `ValidationError` if any of the validation rules fail.
  public func validate(_ object: Object) throws {
    let results = rules.map { $0.validate(object) }
    let failures = results.filter(\.result.isFailure)

    if failures.count > 0 {
      throw ValidationError(failures: failures)
    }
  }

  /// Initializes a new `Validations` instance for a specific object type.
  ///
  /// This initializer sets up an empty collection of validation rules for the given object type.
  ///
  /// - Parameter type: The type of the object being validated.
  public init(of type: Object.Type) {
    self.rules = []
  }
}

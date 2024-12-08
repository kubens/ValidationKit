//
//  Validator.swift
//  KBValidation
//
//  Created by kubens.com on 01/12/2024.
//

import Foundation

/// A type that encapsulates validation logic for a specific type of value.
/// Allows the validation of any value and returns a `ValidatorResult` indicating success or failure.
///
/// - Parameters:
///   - T: The type of value to be validated.
public struct Validator<Value>: Sendable where Value: Sendable {

  /// The closure that performs the validation.
  public var validate: @Sendable (_ value: Value) -> any ValidatorResult

  /// Initializes a new `Validator`.
  ///
  /// - Parameter validate: A closure that defines the validation logic.
  public init(validate: @Sendable @escaping (_: Value) -> any ValidatorResult) {
    self.validate = validate
  }
}

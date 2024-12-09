//
//  Validator+Not.swift
//  KBValidation
//
//  Created by kubens.com on 04/12/2024.
//

import Foundation

extension Validator {

  /// Represents the result of applying a logical **NOT** operation to a validator.
  ///
  /// `NotValidatorResult` inverts the outcome of an existing `ValidatorResult`.
  /// If the original validator passes, the `NotValidatorResult` fails, and vice versa.
  public struct NotValidatorResult: ValidatorResult {

    /// The original validation result being inverted.
    public let result: ValidatorResult

    /// Indicates whether the inverted validation has failed.
    public var isFailure: Bool {
      !result.isFailure
    }

    /// Provides a description of the validation success.
    public var successDescription: String? {
      result.failureDescription
    }

    /// Provides a description of the validation failure.
    public var failureDescription: String? {
      result.successDescription
    }
  }

  /// Creates a validator that inverts the result of another validator.
  ///
  /// This method allows you to define a validator that fails when the original validator passes, and passes when the original validator fails.
  /// It is useful for scenarios where you need to ensure that a value does **not** satisfy certain conditions.
  ///
  /// - Parameter validator: The original `Validator` to invert.
  /// - Returns: A new `Validator` that inversely applies the original validator's logic.
  static public func not(_ validator: Validator<Value>) -> Validator {
    Validator { value in
      NotValidatorResult(result: validator.validate(value))
    }
  }
}

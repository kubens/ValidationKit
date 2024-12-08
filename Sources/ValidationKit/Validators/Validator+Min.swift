//
//  Validator+Min.swift
//  KBValidation
//
//  Created by kubens.com on 04/12/2024.
//

import Foundation

extension Validator {

  /// Represents the result of a minimum value validation.
  public struct MinValidatorResult<T>: ValidatorResult where T: Comparable & Sendable {

    /// The actual value being validated.
    public let value: Value

    /// The minimum acceptable value for the validation.
    public let min: T

    /// Indicates whether the validation has failed.
    public let isFailure: Bool

    /// Provides a description when the validation succeeds.
    public var successDescription: String? {
      "value \(value) is greater than or equal to \(min)"
    }

    /// Provides a description when the validation fails.
    public var failureDescription: String? {
      "value \(value) is less than \(min)"
    }
  }
}

extension Validator where Value: Comparable {

  /// Creates a validator that checks if a value is greater than or equal to a specified minimum.
  ///
  /// - Parameter min: The minimum acceptable value.
  /// - Returns: A `Validator` that validates whether the value is greater than or equal to `min`.
  public static func min(_ min: Value) -> Validator {
    Validator { value in
      MinValidatorResult(value: value, min: min, isFailure: value < min)
    }
  }
}

extension Validator where Value: Collection {

  /// Creates a validator that checks if the collection's length is less than or equal to a specified maximum.
  ///
  /// This validator compares the count of elements in the collection against the provided minimum length.
  ///
  /// - Parameter length: The minimum acceptable number of elements in the collection.
  /// - Returns: A `Validator` that validates whether the collection's length is greater than or equal to `length`.
  public static func min(length: Int) -> Validator {
    Validator { value in
      MinValidatorResult(value: value, min: length, isFailure: value.count < length)
    }
  }
}

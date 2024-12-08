//
//  Validator+Max.swift
//  KBValidation
//
//  Created by kubens.com on 04/12/2024.
//

import Foundation

extension Validator {

  /// Represents the result of a maximum value validation.
  public struct MaxValidatorResult<T>: ValidatorResult where T: Comparable & Sendable {

    /// The actual value being validated.
    public let value: Value

    /// The maximum acceptable value for the validation.
    public let max: T

    /// Determines if the validation has failed.
    public let isFailure: Bool

    /// Provides a description when the validation succeeds.
    public var successDescription: String? {
      "value \(value) is less than or equal to \(max)"
    }

    /// Provides a description when the validation fails.
    public var failureDescription: String? {
      "value \(value) is greater than \(max)"
    }
  }
}

extension Validator where Value: Comparable {

  /// Creates a validator that checks if a value is less than or equal to a specified maximum.
  ///
  /// - Parameter max: The maximum acceptable value.
  /// - Returns: A `Validator` that validates whether the value is less than or equal to `max`.
  public static func max(_ max: Value) -> Validator {
    Validator { value in
      MaxValidatorResult(value: value, max: max, isFailure: value > max)
    }
  }
}

extension Validator where Value: Collection {

  /// Creates a validator that checks if the collection's length is less than or equal to a specified maximum.
  ///
  /// This validator compares the count of elements in the collection against the provided maximum length.
  ///
  /// - Parameter length: The maximum acceptable number of elements in the collection.
  /// - Returns: A `Validator` that validates whether the collection's length is less than or equal to `length`.
  public static func max(length: Int) -> Validator {
    Validator { value in
      MaxValidatorResult(value: value, max: length, isFailure: value.count > length)
    }
  }
}

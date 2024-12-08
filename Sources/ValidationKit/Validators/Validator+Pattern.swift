//
//  Validator+Pattern.swift
//  KBValidation
//
//  Created by kubens.com on 02/12/2024.
//

import Foundation

extension Validator where Value == String {

  /// Represents the result of a regex pattern validation.
  public struct PatternValidatorResult: ValidatorResult {

    /// The pattern used for validation.
    public let pattern: String

    /// Indicates whether the string matches the regex pattern.
    public let isValidPattern: Bool

    /// Indicates whether the validation failed.
    public var isFailure: Bool {
      !isValidPattern
    }

    /// Provides a description of the validation success.
    public var successDescription: String? {
      "is a valid pattern '\(pattern)'"
    }

    /// Provides a description of the validation failure.
    public var failureDescription: String? {
      "is not a valid pattern '\(pattern)'"
    }
  }

  /// Creates a validator that checks if a string matches a given regex pattern.
  ///
  /// This validator uses the provided regex pattern to validate the input string.
  /// If the string matches the entire regex pattern, validation succeeds.
  /// If the string does not match the pattern or if the pattern is invalid, validation fails.
  ///
  /// - Parameter pattern: The regex pattern used for validation.
  /// - Returns: A `Validator` that checks if the string matches the pattern.
  static public func pattern(_ pattern: String) -> Validator {
    Validator { value in
      if let range = value.range(of: pattern, options: [.regularExpression]) {
        let isValidPattern = range.lowerBound == value.startIndex && range.upperBound == value.endIndex
        return PatternValidatorResult(pattern: pattern, isValidPattern: isValidPattern)
      } else {
        return PatternValidatorResult(pattern: pattern, isValidPattern: false)
      }
    }
  }
}

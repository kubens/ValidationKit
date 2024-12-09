//
//  Validator+And.swift
//  ValidationKit
//
//  Created by kubens.com on 07/12/2024.
//

import Foundation

extension Validator {

  /// Represents the result of combining two validators using logical AND.
  ///
  /// `AndValidatorResult` holds the results of two individual validators and determines
  /// the overall validation outcome based on their combination. The validation fails
  /// if either of the validators fails.
  public struct AndValidatorResult: ValidatorResult {

    /// The result from the first validator.
    public let left: ValidatorResult

    /// The result from the second validator.
    public let right: ValidatorResult

    /// Indicates whether the combined validation has failed.
    public var isFailure: Bool {
      left.isFailure || right.isFailure
    }

    /// Provides a description when the combined validation succeeds.
    public var successDescription: String? {
      switch (left.isFailure, right.isFailure) {
      case (false, false):
        left.successDescription.flatMap { leftDescription in
          right.successDescription.map { rightDescription in
            "\(leftDescription) and \(rightDescription)"
          }
        }
      default: nil
      }
    }

    /// Provides a description when the combined validation fails.
    public var failureDescription: String? {
      switch (left.isFailure, right.isFailure) {
      case (true, true):
        left.failureDescription.flatMap { leftDescription in
          right.failureDescription.map { right in
            "\(leftDescription) and \(right)"
          }
        }
      case (true, false): left.failureDescription
      case (false, true): right.failureDescription
      default: nil
      }
    }
  }

  /// Combines two validators using logical AND.
  ///
  /// The combined validator succeeds only if both the `lhs` and `rhs` validators succeed.
  /// If either validator fails, the combined validator fails.
  ///
  /// - Parameters:
  ///   - lhs: The first `Validator` to combine.
  ///   - rhs: The second `Validator` to combine.
  /// - Returns: A new `Validator` that represents the logical AND of `lhs` and `rhs`.
  public static func `and`(_ lhs: Validator<Value>, _ rhs: Validator<Value>) -> Validator<Value> {
    Validator { value in
      AndValidatorResult(left: lhs.validate(value), right: rhs.validate(value))
    }
  }
}

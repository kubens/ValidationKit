//
//  Validator+Or.swift
//  ValidationKit
//
//  Created by kubens.com on 06/12/2024.
//

import Foundation

extension Validator {

  /// Represents the result of combining two validators using logical OR.
  ///
  /// `OrValidatorResult` holds the results of two individual validators and determines
  /// the overall validation outcome based on their combination. The validation succeeds
  /// if at least one of the validators succeeds.
  public struct OrValidatorResult: ValidatorResult {

    /// The result from the first validator.
    public let left: ValidatorResult

    /// The result from the second validator.
    public let right: ValidatorResult

    /// Indicates whether the combined validation has failed.
    ///
    /// The validation fails only if both the left and right validators fail.
    public var isFailure: Bool {
      left.isFailure && right.isFailure
    }

    /// Provides a description when the combined validation succeeds.
    public var successDescription: String? {
      switch (left.successDescription, right.successDescription) {
      case let (.some(left), .some(right)): "\(left) and \(right)"
      case let (.some(left), .none): left
      case let (.none, .some(right)): right
      case (.none, .none): nil
      }
    }

    /// Provides a description when the combined validation fails.
    public var failureDescription: String? {
      switch (left.failureDescription, right.failureDescription) {
      case let (.some(left), .some(right)): "\(left) and \(right)"
      case let (.some(left), .none): left
      case let (.none, .some(right)): right
      case (.none, .none): nil
      }
    }

    /// Provides a textual representation of the validation result.
    public var description: String {
      switch (left.isFailure, right.isFailure) {
      case (true, true): failureDescription ?? "validation failed"
      case (true, false): right.successDescription ?? "validation succeeded"
      case (false, false): successDescription ?? "validation succeeded"
      case (false, true): left.successDescription ?? "validation succeeded"
      }
    }
  }

  /// Combines two validators using logical OR.
  ///
  /// The combined validator succeeds if at least one of the `lhs` or `rhs` validators succeeds.
  /// It fails only if both validators fail.
  ///
  /// - Parameters:
  ///   - lhs: The first `Validator` to combine.
  ///   - rhs: The second `Validator` to combine.
  /// - Returns: A new `Validator` that represents the logical OR of `lhs` and `rhs`.
  public static func or(_ lhs: Validator<Value>, _ rhs: Validator<Value>) -> Validator<Value> {
    Validator { value in
      OrValidatorResult(left: lhs.validate(value), right: rhs.validate(value))
    }
  }
}

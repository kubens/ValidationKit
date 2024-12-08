//
//  Validator+AllOf.swift
//  KBValidation
//
//  Created by kubens.com on 04/12/2024.
//

import Foundation

extension Validator {

  /// Represents the result of applying multiple validators to a single value.
  ///
  /// `AllValidatorResult` aggregates the outcomes of several `ValidatorResult` instances.
  /// It determines the overall validation status based on whether any of the individual validations fail.
  public struct AllOfValidatorResult: ValidatorResult {

    /// An array of individual validation results.
    public let results: [any ValidatorResult]

    /// Indicates whether **any** of the validations have failed.
    public var isFailure: Bool {
      results.contains { $0.isFailure }
    }

    /// A combined description of all validation successes.
    public var successDescription: String? {
      results
        .filter { $0.isFailure == false }
        .compactMap { $0.successDescription }
        .joined(separator: " and ")
    }

    /// A combined description of all validation failures.
    public var failureDescription: String? {
      results
        .filter { $0.isFailure == true }
        .compactMap { $0.failureDescription }
        .joined(separator: " and ")
    }
  }

  /// Creates a validator that combines multiple validators using a logical AND operation.
  ///
  /// This method allows you to chain multiple validators so that a value must pass **all** validations to be considered valid.
  /// If **any** of the validators fail, the combined validation fails, and all corresponding failure descriptions are aggregated.
  ///
  /// - Parameters:
  ///   - validators: A variadic list of `Validator<Value>` instances to combine.
  /// - Returns: A new `Validator` that applies all provided validators to a value.
  static public func allOf(_ validators: Validator<Value>...) -> Validator {
    Validator { value in
      AllOfValidatorResult(results: validators.map({ $0.validate(value) }))
    }
  }
}

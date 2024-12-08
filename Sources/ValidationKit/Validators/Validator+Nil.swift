//
//  Validator+Nil.swift
//  KBValidation
//
//  Created by kubens.com on 05/12/2024.
//

import Foundation

extension Validator where Value: AnyOptional {

  /// Represents the result of validating whether an optional value is `nil`.
  ///
  /// `NilValidatorResult` captures whether an optional value is `nil` or not.
  /// It provides appropriate descriptions based on the presence or absence of a value.
  public struct NilValidatorResult: ValidatorResult {

    /// Indicates whether the optional value is `nil`.
    public let isNil: Bool

    /// A description provided when the validation succeeds (i.e., the value is `nil`).
    public let successDescription: String? = "is nil"

    /// A description provided when the validation fails (i.e., the value is not `nil`).
    public let failureDescription: String? = "is not nil"

    /// Determines if the validation has failed.
    ///
    /// - Returns: `true` if the optional value is not `nil`; otherwise, `false`.
    public var isFailure: Bool {
      !isNil
    }
  }

  /// Creates a validator that checks whether an optional value is `nil`.
  ///
  /// This validator succeeds if the optional value is `nil` and fails otherwise.
  ///
  /// - Returns: A `Validator` that validates whether an optional value is `nil`.
  public static var `nil`: Validator<Value> {
    Validator<Value> { value in
      NilValidatorResult(isNil: value.isNil)
    }
  }
}

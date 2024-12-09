//
//  Validator+Stub.swift
//  KBValidation
//
//  Created by kubens.com on 04/12/2024.
//

@testable import ValidationKit

/// An extension of the `Validator` struct to provide stub validators for testing purposes.
internal extension Validator {

  /// A stub implementation of `ValidatorResult` for testing purposes.
  struct StubValidatorResult: ValidatorResult {
    /// Determines if the validation has failed.
    let isFailure: Bool

    /// A description provided when the validation succeeds.
    let successDescription: String? = "success description"

    /// A description provided when the validation fails.
    let failureDescription: String? = "failure description"
  }

  /// Creates a stub `Validator` that returns a predefined validation result.
  static func stub(_ isValid: Bool) -> Validator {
    Validator { _ in StubValidatorResult(isFailure: !isValid) }
  }
}

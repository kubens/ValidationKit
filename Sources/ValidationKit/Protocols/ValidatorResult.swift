//
//  ValidatorResult.swift
//  KBValidation
//
//  Created by kubens.com on 01/12/2024.
//

/// A protocol representing the result of a validation operation.
///
/// Conforming types provide information about whether the validation succeeded or failed,
/// along with optional descriptive messages for both outcomes.
public protocol ValidatorResult: Sendable, CustomStringConvertible {

  /// Indicates whether the validation operation failed.
  ///
  /// - Returns: `true` if the validation failed; otherwise, `false`.
  var isFailure: Bool { get }

  /// Provides a description of the validation success.
  ///
  /// - Returns: A string describing the success of the validation.
  var successDescription: String? { get }

  /// Provides a description of the validation failure.
  ///
  /// - Returns: A string describing why the validation failed.
  var failureDescription: String? { get }
}

// MARK: - Default implementation

extension ValidatorResult {

  /// Provides a textual representation of the validation result.
  public var description: String {
    switch isFailure {
    case true: failureDescription ?? "validation failed"
    case false: successDescription ?? "validation succeeded"
    }
  }
}

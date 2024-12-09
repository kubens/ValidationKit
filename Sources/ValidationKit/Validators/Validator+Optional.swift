//
//  Validator+Optional.swift
//  ValidationKit
//
//  Created by kubens.com on 07/12/2024.
//

extension Validator {

  /// Represents the result of validating an optional value.
  ///
  /// `OptionalValidatorResult` encapsulates the result of validating an optional value.
  /// It holds an optional `ValidatorResult` that represents the outcome of validating the unwrapped value.
  /// If the optional is `nil`, the `result` will be `nil`, indicating that no further validation was performed.
  public struct OptionalValidatorResult: ValidatorResult {

    /// The result of validating the unwrapped value.
    ///
    /// - Note: If the optional value is `nil`, this will be `nil`, indicating that the validation
    ///         related to the unwrapped value was not performed.
    public let result: ValidatorResult?

    /// Indicates whether the validation has failed.
    ///
    /// - Returns: `true` if the unwrapped value failed validation; otherwise, `false`.
    public var isFailure: Bool {
      guard let result else { return true }
      return result.isFailure
    }

    /// Provides a description when the validation succeeds.
    ///
    /// - Returns: The success description from the unwrapped value's validation result, if available.
    public var successDescription: String? {
      result?.successDescription
    }

    /// Provides a description when the validation fails.
    ///
    /// - Returns: The failure description from the unwrapped value's validation result, if available.
    public var failureDescription: String? {
      guard let result else { return "no validation performed" }
      return result.failureDescription
    }
  }

  // MARK: - OR Validators

  /// Combines an optional validator and a non-optional validator using logical OR.
  ///
  /// The combined validator succeeds if either:
  /// 1. The `lhs` optional validator succeeds (e.g., the value is `nil` if allowed).
  /// 2. The `rhs` validator succeeds when applied to the unwrapped value.
  ///
  /// - Parameters:
  ///   - lhs: The first `Validator` for the optional value to combine.
  ///   - rhs: The second `Validator` to apply to the unwrapped value.
  /// - Returns: A new `Validator` that represents the logical OR of `lhs` and `rhs`.
  public static func or(_ lhs: Validator<Value?>, _ rhs: Validator<Value>) -> Validator<Value?> {
    .or(lhs, Validator<Value?> { value in
      OptionalValidatorResult(result: value.flatMap(rhs.validate))
    })
  }

  /// Combines an optional validator and a non-optional validator using logical OR.
  ///
  /// The combined validator succeeds if either:
  /// 1. The `lhs` validator succeeds when applied to the unwrapped value.
  /// 2. The `rhs` optional validator succeeds (e.g., the value is `nil` if allowed).
  ///
  /// - Parameters:
  ///   - lhs: The first `Validator` for the optional value to combine.
  ///   - rhs: The second `Validator` to apply to the unwrapped value.
  /// - Returns: A new `Validator` that represents the logical OR of `lhs` and `rhs`.
  public static func or(_ lhs: Validator<Value>, _ rhs: Validator<Value?>) -> Validator<Value?> {
    .or(Validator<Value?> { value in
      OptionalValidatorResult(result: value.flatMap(lhs.validate))
    }, rhs)
  }

  // MARK: - AND Validators

  /// Combines an optional validator and a non-optional validator using logical AND.
  ///
  /// The combined validator succeeds only if both:
  /// 1. The `lhs` optional validator succeeds (i.e., the optional is not `nil` if required).
  /// 2. The `rhs` validator succeeds when applied to the unwrapped value of the optional.
  ///
  /// If the optional is `nil` and the `lhs` validator does not enforce non-nil,
  /// the combined validator succeeds by default.
  ///
  /// - Parameters:
  ///   - lhs: The first `Validator` for the optional value to combine.
  ///   - rhs: The second `Validator` to apply to the unwrapped value.
  /// - Returns: A new `Validator` that represents the logical AND of `lhs` and `rhs`.
  public static func and(_ lhs: Validator<Value?>, _ rhs: Validator<Value>) -> Validator<Value?> {
    .and(lhs, Validator<Value?> { value in
      OptionalValidatorResult(result: value.flatMap(rhs.validate))
    })
  }

  /// Combines an optional validator and a non-optional validator using logical AND.
  ///
  /// The combined validator succeeds only if both:
  /// 1. The `lhs` validator succeeds when applied to the unwrapped value of the optional.
  /// 2. The `rhs` optional validator succeeds (i.e., the optional is not `nil` if required).
  ///
  /// If the optional is `nil` and the `lhs` validator does not enforce non-nil,
  /// the combined validator succeeds by default.
  ///
  /// - Parameters:
  ///   - lhs: The first `Validator` for the optional value to combine.
  ///   - rhs: The second `Validator` to apply to the unwrapped value.
  /// - Returns: A new `Validator` that represents the logical AND of `lhs` and `rhs`.
  public static func and(_ lhs: Validator<Value>, _ rhs: Validator<Value?>) -> Validator<Value?> {
    .and(Validator<Value?> { value in
      OptionalValidatorResult(result: value.flatMap(lhs.validate))
    }, rhs)
  }
}

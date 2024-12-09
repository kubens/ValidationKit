//
//  Operators+Validator.swift
//  ValidationKit
//
//  Created by kubens.com on 06/12/2024.
//

/// Applies a logical NOT operation to the given validator.
///
/// This prefix operator inverts the result of the provided validator. If the original validator
/// succeeds, the resulting validator will fail, and vice versa.
///
/// - Parameter validator: The validator to invert.
/// - Returns: A new `Validator` instance representing the logical NOT of the original validator.
public prefix func ! <Value: Sendable>(_ validator: Validator<Value>) -> Validator<Value> {
  Validator<Value>.not(validator)
}

// MARK: - OR

/// Combines two validators using a logical OR operation.
///
/// The resulting validator succeeds if **either** the left-hand side (lhs) or the right-hand side (rhs)
/// validator succeeds. It fails only if **both** validators fail.
///
/// - Parameters:
///   - lhs: The first validator to combine.
///   - rhs: The second validator to combine.
/// - Returns: A new `Validator` representing the logical OR of `lhs` and `rhs`.
public func || <Value: Sendable>(lhs: Validator<Value>, rhs: Validator<Value>) -> Validator<Value> {
  Validator<Value>.or(lhs, rhs)
}

/// Combines an optional validator and a non-optional validator using a logical OR operation.
///
/// The resulting validator succeeds if **either** the left-hand side (lhs) optional validator succeeds
/// or the right-hand side (rhs) non-optional validator succeeds when applied to the unwrapped value.
/// It fails only if **both** validators fail.
///
/// - Parameters:
///   - lhs: The first optional validator to combine.
///   - rhs: The second non-optional validator to combine.
/// - Returns: A new `Validator` representing the logical OR of `lhs` and `rhs`.
public func || <Value: Sendable>(lhs: Validator<Value?>, rhs: Validator<Value>) -> Validator<Value?> {
  Validator<Value>.or(lhs, rhs)
}

/// Combines a non-optional validator and an optional validator using a logical OR operation.
///
/// The resulting validator succeeds if **either** the left-hand side (lhs) non-optional validator succeeds
/// or the right-hand side (rhs) optional validator succeeds when applied to the unwrapped value.
/// It fails only if **both** validators fail.
///
/// - Parameters:
///   - lhs: The first non-optional validator to combine.
///   - rhs: The second optional validator to combine.
/// - Returns: A new `Validator` representing the logical OR of `lhs` and `rhs`.
public func || <Value: Sendable>(lhs: Validator<Value>, rhs: Validator<Value?>) -> Validator<Value?> {
  Validator<Value>.or(lhs, rhs)
}

// MARK: - AND

/// Combines two validators using a logical AND operation.
///
/// The resulting validator succeeds only if **both** the left-hand side (lhs) and the right-hand side (rhs)
/// validators succeed. It fails if **either** validator fails.
///
/// - Parameters:
///   - lhs: The first validator to combine.
///   - rhs: The second validator to combine.
/// - Returns: A new `Validator` representing the logical AND of `lhs` and `rhs`.
public func && <Value: Sendable>(lhs: Validator<Value>, rhs: Validator<Value>) -> Validator<Value> {
  Validator<Value>.and(lhs, rhs)
}

/// Combines an optional validator and a non-optional validator using a logical AND operation.
///
/// The resulting validator succeeds only if **both** the left-hand side (lhs) optional validator succeeds
/// and the right-hand side (rhs) non-optional validator succeeds when applied to the unwrapped value.
/// It fails if **either** validator fails.
///
/// - Parameters:
///   - lhs: The first optional validator to combine.
///   - rhs: The second non-optional validator to combine.
/// - Returns: A new `Validator` representing the logical AND of `lhs` and `rhs`.
public func && <Value: Sendable>(lhs: Validator<Value?>, rhs: Validator<Value>) -> Validator<Value?> {
  Validator<Value>.and(lhs, rhs)
}

/// Combines a non-optional validator and an optional validator using a logical AND operation.
///
/// The resulting validator succeeds only if **both** the left-hand side (lhs) non-optional validator succeeds
/// and the right-hand side (rhs) optional validator succeeds when applied to the unwrapped value.
/// It fails if **either** validator fails.
///
/// - Parameters:
///   - lhs: The first non-optional validator to combine.
///   - rhs: The second optional validator to combine.
/// - Returns: A new `Validator` representing the logical AND of `lhs` and `rhs`.
public func && <Value: Sendable>(lhs: Validator<Value>, rhs: Validator<Value?>) -> Validator<Value?> {
  Validator<Value>.and(lhs, rhs)
}

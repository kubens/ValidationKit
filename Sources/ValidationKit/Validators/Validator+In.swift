//
//  Validator+In.swift
//  ValidationKit
//
//  Created by Jakub Łaptaś on 09/12/2024.
//

import Foundation

extension Validator where Value: Equatable, Value: CustomStringConvertible {

  /// Represents the result of validating whether a value is contained within a specified collection of values.
  ///
  /// The `InValidatorResult` struct checks if a given `item` exists within the provided `items` array.
  /// It provides descriptive feedback based on the validation outcome, indicating success or failure along with appropriate messages.
  ///
  /// - Type Parameters:
  ///   - Value: The type of the value being validated. Must conform to `Equatable` for comparison and `CustomStringConvertible` for descriptive output.
  public struct InValidatorResult: ValidatorResult {

    /// The value being validated.
    public let item: Value

    /// The collection of allowed values against which the `item` is validated.
    public let items: [Value]

    /// Indicates whether the validation has failed.
    public var isFailure: Bool {
      !items.contains(item)
    }

    /// A descriptive message detailing the success of the validation.
    public var successDescription: String? {
      "is \(makeDescription(for: self.items))"
    }

    /// A descriptive message detailing the failure of the validation.
    public var failureDescription: String? {
      "is not \(makeDescription(for: self.items))"
    }

    /// Generates a descriptive string based on the number of valid values.
    private func makeDescription(for items: [Value]) -> String {
      switch items.count {
      case 1: return items[0].description
      case 2: return "\(items[0].description) or \(items[1].description)"
      default:
        let first = items[0..<items.count - 1].map(\.description).joined(separator: ", ")
        let last = items[items.count - 1].description
        return "\(first) or \(last)"
      }
    }
  }

  /// Creates a validator that checks whether a value is contained within a specified sequence of values.
  ///
  /// This validator ensures that the value exists within the provided `sequence`. It's useful for validating that
  /// input data matches one of the expected predefined values, enhancing type safety and data integrity.
  ///
  /// - Parameter sequence: A sequence of values against which the input value will be validated.
  /// - Returns: A `Validator` instance that performs the inclusion check.
  public static func `in`<S>(_ sequence: S) -> Validator<Value> where S: Sequence & Sendable, S.Element == Value {
    Validator { value in
      InValidatorResult(item: value, items: .init(sequence))
    }
  }

  /// Creates a validator that checks whether a value is contained within a specified list of values.
  ///
  /// This is a convenience method that allows you to pass a variadic list of values instead of a sequence.
  ///
  /// - Parameter array: A variadic list of values against which the input value will be validated.
  /// - Returns: A `Validator` instance that performs the inclusion check.
  public static func `in`(_ array: Value...) -> Validator<Value> {
    .in(array)
  }
}

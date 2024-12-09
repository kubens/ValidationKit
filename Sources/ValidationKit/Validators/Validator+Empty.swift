//
//  Validator+Empty.swift
//  KBValidation
//
//  Created by kubens.com on 03/12/2024.
//

import Foundation

extension Validator where Value: Collection {

  /// Represents the result of validating whether a collection is empty.
  public struct EmptyValidatorResult: ValidatorResult {

    /// Indicates whether the collection is empty.
    public let isEmpty: Bool

    /// Provides a description of the validation success.
    public let successDescription: String? = "is empty"

    /// Provides a description of the validation failure.
    public let failureDescription: String? = "is not empty"

    /// Indicates whether the validation failed.
    public var isFailure: Bool {
      !isEmpty
    }
  }

  /// Creates a validator that checks if a collection is empty.
  ///
  /// This static property provides a `Validator` instance that validates whether
  /// a collection contains no elements. If the collection is not empty,
  /// the validation fails with an appropriate failure description.
  ///
  /// - Returns: A `Validator` that ensures the collection is empty.
  public static var empty: Validator {
    Validator { value in
      EmptyValidatorResult(isEmpty: value.isEmpty)
    }
  }
}

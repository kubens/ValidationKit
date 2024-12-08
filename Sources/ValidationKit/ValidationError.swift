//
//  ValidationError.swift
//  KBValidation
//
//  Created by kubens.com on 01/12/2024.
//

import Foundation

/// Represents an error that occurs during validation, containing a collection of validation failures.
public struct ValidationError: Error, CustomStringConvertible {

  /// An array of `ValidationResult` instances representing individual validation failures.
  public let failures: [ValidationResult]

  /// A human-readable description of the validation errors.
  public var description: String {
    failures.map(\.description).joined(separator: ", ")
  }

  /// Initializes a new instance of `ValidationError` with the provided validation failures.
  ///
  /// This initializer is marked as `internal`, restricting its usage to within the same module.
  /// It assigns the provided array of `ValidationResult` to the `failures` property.
  ///
  /// - Parameter failures: An array of `ValidationResult` representing the validation failures.
  internal init(failures: [ValidationResult]) {
    self.failures = failures
  }
}

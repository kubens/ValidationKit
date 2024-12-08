//
//  Validatable.swift
//  KBValidation
//
//  Created by kubens.com on 01/12/2024.
//

import Foundation

/// A protocol that defines an object as capable of validation.
public protocol Validatable {

  /// Defines the validation rules for the object.
  ///
  /// Conforming types implement this method to specify validation rules.
  /// The provided `Validations` collection is where rules should be added.
  ///
  /// - Parameter validations: A mutable reference to a `Validations` collection
  ///   where validation rules are defined.
  func validations(_ validations: inout Validations<Self>)

  /// Executes all validation rules for the object.
  ///
  /// This method validates the object by applying all rules defined in
  /// `validations(_:)`. If any rule fails, it throws an error, ensuring
  /// that the object meets its constraints.
  ///
  /// - Throws: A validation error if any rule fails.
  func validate() throws
}

// MARK: - Default implementation
extension Validatable where Self: Sendable {

  /// Default implementation of the `validate()` method for `Validatable`.
  ///
  /// This method creates a new `Validations` collection, populates it by calling
  /// `validations(_:)`, and then evaluates all defined validation rules for the object.
  ///
  /// - Throws: A validation error if any rule fails.
  public func validate() throws {
    var validations = Validations(of: Self.self)
    self.validations(&validations)

    try validations.validate(self)
  }
}

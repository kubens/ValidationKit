//
//  EmptyValidatorTests.swift
//  KBValidation
//
//  Created by kubens.com on 04/12/2024.
//

import Testing
@testable import ValidationKit

@Suite("Empty Validator", .tags(.validator))
struct EmptyValidatorTests {

  @Test("validate should pass when the string is empty")
  func validateEmptyStringWithSuccess() {
    let value = ""
    let result = Validator.empty.validate(value)

    #expect(result.isFailure == false)
    #expect(result.description == "is empty")
  }

  @Test("validate should pass when the collection is empty")
  func validateEmptyCollectionWithSuccess() {
    let value: [Int] = []
    let result = Validator.empty.validate(value)

    #expect(result.isFailure == false)
    #expect(result.description == "is empty")
  }

  @Test("validate should fail when the string is not empty")
  func validateNonEmptyStringWithSuccess() {
    let value = "Hello"
    let result = Validator.empty.validate(value)
    
    #expect(result.isFailure == true)
    #expect(result.description == "is not empty")
  }

  @Test("validate should fail when the collection is not empty")
  func validateNonEmptyCollectionWithFailure() {
    let value = [1, 2]
    let result = Validator.empty.validate(value)

    #expect(result.isFailure == true)
    #expect(result.failureDescription == "is not empty")
  }
}

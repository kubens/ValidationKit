//
//  MinValidatorTests.swift
//  KBValidation
//
//  Created by kubens.com on 04/12/2024.
//

import Testing
@testable import ValidationKit

@Suite("Min Validator", .tags(.validator))
struct MinValidatorTests {

  @Test("validate should pass when value is equal to min")
  func validateEqualToMin() {
    let min = 1
    let value = 1
    let result = Validator.min(min).validate(value)
    
    #expect(result.isFailure == false)
    #expect(result.description == "value \(value) is greater than or equal to \(min)")
  }

  @Test("validate should pass when String lenght is qual to min")
  func validateEqualToMinStringLength() {
    let min = 1
    let value = "a"
    let result = Validator.min(length: min).validate(value)

    #expect(result.isFailure == false)
    #expect(result.description == "value \(value) is greater than or equal to \(min)")
  }

  @Test("validate should pass when value is greater than min")
  func validateGreaterThanMin() {
    let min = 1
    let value = 2
    let result = Validator.min(min).validate(value)

    #expect(result.isFailure == false)
    #expect(result.description == "value \(value) is greater than or equal to \(min)")
  }

  @Test("validate should pass when String length is greater than min")
  func validateGreaterThanMinStringLength() {
    let min = 1
    let value = "ab"
    let result = Validator.min(length: min).validate(value)
    
    #expect(result.isFailure == false)
    #expect(result.description == "value \(value) is greater than or equal to \(min)")
  }

  @Test("validate should fail when value is less than min")
  func validateLessThanMin() {
    let min = 1
    let value = 0
    let result = Validator.min(min).validate(value)
    
    #expect(result.isFailure == true)
    #expect(result.description == "value \(value) is less than \(min)")
  }

  @Test("validate should fail when String lenght is less than min")
  func validateLessThanMinStringLength() {
    let min = 2
    let value = "a"
    let result = Validator.min(length: min).validate(value)
    
    #expect(result.isFailure == true)
    #expect(result.description == "value \(value) is less than \(min)")
  }
}

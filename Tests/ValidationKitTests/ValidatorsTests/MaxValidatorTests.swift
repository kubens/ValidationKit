//
//  MaxValidatorTests.swift
//  KBValidation
//
//  Created by kubens.com on 04/12/2024.
//

import Testing
@testable import ValidationKit

@Suite("Max Validator", .tags(.validator))
struct MaxValidatorTests {

  @Test("validate should pass when value is equal to max")
  func validateEqualToMax() {
    let max = 1
    let value = 1
    let result = Validator.max(max).validate(value)

    #expect(result.isFailure == false)
    #expect(result.description == "value \(value) is less than or equal to \(max)")
  }

  @Test("validate should pass when String lenght is equal to max")
  func validateEqualToMaxStringLenght() {
    let max = 2
    let value = "ab"
    let result = Validator.max(length: max).validate(value)

    #expect(result.isFailure == false)
    #expect(result.description == "value \(value) is less than or equal to \(max)")
  }

  @Test("validate should pass when value is less than max")
  func validateLessThanMax() {
    let max = 2
    let value = 1
    let result = Validator.max(max).validate(value)

    #expect(result.isFailure == false)
    #expect(result.description == "value \(value) is less than or equal to \(max)")
  }

  @Test("validate should pass when String lenght is less than max")
  func validateLessThanMaxStringLenght() {
    let max = 3
    let value = "abc"
    let result = Validator.max(length: max).validate(value)
    
    #expect(result.isFailure == false)
    #expect(result.description == "value \(value) is less than or equal to \(max)")
  }

  @Test("validate should fail when value is greater than max")
  func validateGreateThanMax() {
    let max = 1
    let value = 2
    let result = Validator.max(max).validate(value)

    #expect(result.isFailure == true)
    #expect(result.description == "value \(value) is greater than \(max)")
  }

  @Test("validate should fail when String lenght is greate than max")
  func validateGreateThanMaxStringLenght() {
    let max = 2
    let value = "abcd"
    let result = Validator.max(length: max).validate(value)
    
    #expect(result.isFailure == true)
    #expect(result.description == "value \(value) is greater than \(max)")
  }
}

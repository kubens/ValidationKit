//
//  PatternValidatorTests.swift
//  KBValidation
//
//  Created by kubens.com on 04/12/2024.
//

import Testing
@testable import ValidationKit

@Suite("Pattern Validator", .tags(.validator))
struct PatternValidatorTests {

  @Test("validate should pass when the value matches the regex pattern")
  func validateValueWithSuccess() {
    let value = "ABC"
    let pattern = "^[A-Z]{3}$"
    let result = Validator.pattern(pattern).validate(value)

    #expect(result.isFailure == false)
    #expect(result.description == "is a valid pattern '\(pattern)'")
  }

  @Test("validate should fail when the value does not match the regex pattern")
  func validateValueWithFailure() {
    let value = "abcd"
    let pattern = "^[A-Z]{3}$"
    let result = Validator.pattern(pattern).validate(value)
    
    #expect(result.isFailure == true)
    #expect(result.description == "is not a valid pattern '\(pattern)'")
  }

  @Test("validate should fail when the regex pattern is invalid")
  func validateWithInvalidRegexPattern() {
    let value = "ABC"
    let invalidPattern = "[A-Z{3}$" // Missing closing bracket

    let result = Validator.pattern(invalidPattern).validate(value)
    #expect(result.isFailure == true)
    #expect(result.description == "is not a valid pattern '\(invalidPattern)'")
  }
}

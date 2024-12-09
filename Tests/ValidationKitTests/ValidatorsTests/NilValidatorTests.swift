//
//  NilValidatorTests.swift
//  KBValidation
//
//  Created by kubens.com on 05/12/2024.
//

import Testing
@testable import ValidationKit

@Suite("Nil Validator")
struct NilValidatorTests {

  @Test("validate should pass when value is nil")
  func validateNilSuccessed() {
    let value: Int? = nil
    let result = Validator.nil.validate(value)

    #expect(result.isFailure == false)
    #expect(result.description == "is nil")
  }

  @Test("validate should not pass when value is not nil")
  func validateNotNilFailed() {
    let value: Int? = 1
    let result = Validator.nil.validate(value)
    
    #expect(result.isFailure == true)
    #expect(result.description == "is not nil")
  }
}

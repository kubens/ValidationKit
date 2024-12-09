//
//  OrValidatorTests.swift
//  ValidationKit
//
//  Created by kubens.com on 08/12/2024.
//

import Testing
@testable import ValidationKit

@Suite("Or Validator")
struct OrValidatorTests {

  @Test("validate should pass when first and second validator pass")
  func validateFirstAndSecondPass() {
    let result = Validator.or(.stub(true), .stub(true)).validate("")

    #expect(result.isFailure == false)
    #expect(result.description == "success description and success description")
  }

  @Test("validate should pass when first validator pass and second validator fail")
  func validateFirstPassAndSecondFail() {
    let result = Validator.or(.stub(true), .stub(false)).validate("")
    
    #expect(result.isFailure == false)
    #expect(result.description == "success description")
  }

  @Test("validate should pass when first validator fail and second validator pass")
  func validateFirstFailAndSecondPass() {
    let result = Validator.or(.stub(false), .stub(true)).validate("")
    
    #expect(result.isFailure == false)
    #expect(result.description == "success description")
  }

  @Test("validate should fail when first and second validator fail")
  func validateFirstAndSecondFail() {
    let result = Validator.or(.stub(false), .stub(false)).validate("")
    
    #expect(result.isFailure == true)
    #expect(result.description == "failure description and failure description")
  }
}

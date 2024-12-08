//
//  AndValidatorTests.swift
//  ValidationKit
//
//  Created by kubens.com on 08/12/2024.
//

import Testing
@testable import ValidationKit

@Suite("And Validator")
struct AndValidatorTests {

  @Test("should pass when first and second validator pass")
  func firstAndSecondValidatorPass() {
    let result = Validator.and(.stub(true), .stub(true)).validate("")

    #expect(result.isFailure == false)
    #expect(result.description == "success description and success description")
  }

  @Test("should fail when first validator pass and second validator fail")
  func firstValidatorPassAndSecondValidatorFail() {
    let result = Validator.and(.stub(true), .stub(false)).validate("")
    
    #expect(result.isFailure == true)
    #expect(result.description == "failure description")
  }

  @Test("should fail when first validator fail and second validator pass")
  func firstValidatorFailAndSecondValidatorPass() {
    let result = Validator.and(.stub(false), .stub(true)).validate("")
    
    #expect(result.isFailure == true)
    #expect(result.description == "failure description")
  }

  @Test("should fail when first and second validator fail")
  func firstAndSecondValidatorFail() {
    let result = Validator.and(.stub(false), .stub(false)).validate("")
    
    #expect(result.isFailure == true)
    #expect(result.description == "failure description and failure description")
  }
}

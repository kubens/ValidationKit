//
//  AllOfValidatorTests.swift
//  KBValidation
//
//  Created by kubens.com on 04/12/2024.
//

import Testing
@testable import ValidationKit

@Suite("AllOf Validator", .tags(.validator))
struct AllOfValidatorTests {

  @Test("validate should pass when all validators successed")
  func validateAllOfValidatorsSuccessed() {
    let result = Validator.allOf(Validator.stub(true), Validator.stub(true)).validate("")

    #expect(result.isFailure == false)
    #expect(result.description == "success description and success description")
  }

  @Test("validate should not pass when any of the validators fail")
  func validateAllOfValidatorsFailed() {
    let result = Validator.allOf(Validator.stub(true), Validator.stub(false)).validate("")
    
    #expect(result.isFailure == true)
    #expect(result.description == "failure description")
  }

  @Test("validate should not pass when all validators failure")
  func validateAllOfValidatorsFailure() {
    let result = Validator.allOf(Validator.stub(false), Validator.stub(false)).validate("")
    
    #expect(result.isFailure == true)
    #expect(result.description == "failure description and failure description")
  }
}

//
//  NotValidatorTests.swift
//  KBValidation
//
//  Created by kubens.com on 04/12/2024.
//

import Testing
@testable import ValidationKit

@Suite("Not Validator", .tags(.validator))
struct NotValidatorTests {

  @Test("validate should pass when the underlying validator fails")
  func validateUnderlyingValidatorFails() {
    let result = Validator.not(.stub(false)).validate("")

    #expect(result.isFailure == false)
    #expect(result.description == "failure description")
  }

  @Test("validate should fail when the underlying validator passes")
  func validateUnderlyingValidatorPasses() {
    let result = Validator.not(.stub(true)).validate("")

    #expect(result.isFailure == true)
    #expect(result.description == "success description")
  }
}

//
//  InValidatorTests.swift
//  ValidationKit
//
//  Created by Jakub Łaptaś on 09/12/2024.
//

import Testing
@testable import ValidationKit

@Suite("In Validator")
struct InValidatorTests {

  enum TestEnum: String, Equatable, CaseIterable, CustomStringConvertible {
    case one
    case two
    case three

    var description: String {
      self.rawValue
    }
  }

  @Test("validate should pass when value is in allowed list", arguments: TestEnum.allCases)
  func validateAllowedValues(value: TestEnum) throws {
    let result = Validator.in(TestEnum.allCases).validate(value)

    #expect(result.isFailure == false)
    #expect(result.description == "is one, two or three")
  }

  @Test("validate should fail when value is not in allowed list")
  func validateNotAllowedValues() throws {
    let value = TestEnum.two
    let result = Validator.in(.one, .three).validate(value)

    #expect(result.isFailure == true)
    #expect(result.description == "is not one or three")
  }
}

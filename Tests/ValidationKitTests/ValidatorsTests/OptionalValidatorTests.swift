//
//  OptionalValidatorTests.swift
//  ValidationKit
//
//  Created by kubens.com on 07/12/2024.
//

import Testing
@testable import ValidationKit

@Suite("Optional Validator", .tags(.validator))
struct OptionalValidatorTests {

  @Suite("OR Validator")
  struct OrValidatorTests {

    @Suite("when value is nil")
    struct whenValueIsNilTests {

      var value: Int? = nil

      @Test("validate should pass when first validator permits nil and omit second validator")
      func validateFirstValidatorOmitSecondValidator() throws {
        let result = Validator.or(.nil, .stub(true)).validate(value)

        #expect(result.isFailure == false)
        #expect(result.description == "is nil")
      }

      @Test("validate should pass when second validator permits nil and omit first validator")
      func validateSecondValidatorOmitFirstValidator() throws {
        let result = Validator.or(.stub(true), .nil).validate(value)

        #expect(result.isFailure == false)
        #expect(result.description == "is nil")
      }
    }

    @Suite("when value is not nil")
    struct whenValueIsNotNilTests {

      var value: Int? = 1

      @Test("validate should pass when first validator premits nil and second validator pass")
      func validateFirstValidatorPremitsNilPassSecondValidatorPass() throws {
        let result = Validator.or(.nil, .stub(true)).validate(value)

        #expect(result.isFailure == false)
        #expect(result.description == "success description")
      }

      @Test("validate should pass when first validator pass and second premits nil")
      func validateFirstValidatorPassSecondValidatorPremitsNil() throws {
        let result = Validator.or(.stub(true), .nil).validate(value)

        #expect(result.isFailure == false)
        #expect(result.description == "success description")
      }

      @Test("validate should fail when first validator premits nil and second validator fail")
      func validateFirstValidatorPremitsNilPassSecondValidatorFail() throws {
        let result = Validator.or(.nil, .stub(false)).validate(value)

        #expect(result.isFailure == true)
        #expect(result.description == "is not nil and failure description")
      }

      @Test("validate should fail when first validator fail and second validator premits nil")
      func validateFirstValidatorFailSecondValidatorPremitsNil() throws {
        let result = Validator.or(.stub(false), .nil).validate(value)

        #expect(result.isFailure == true)
        #expect(result.description == "failure description and is not nil")
      }
    }
  }

  @Suite("AND Validator")
  struct ANDValidatorTests {

    @Suite("when value is nil")
    struct whenValueIsNil {

      var value: Int? = nil

      @Test("validate should fail when first validator not permits nil and second validator try validate")
      func validateFirstValidatorNotPermitsNilPassSecondValidatorPass() {
        let result = Validator.and(.not(.nil), .max(1)).validate(value)

        #expect(result.isFailure == true)
        #expect(result.description == "is nil and no validation performed")
      }

      @Test("validate should fail when first validator try validate and second validator  not permits nil")
      func validateFirstValidatorPassSecondValidatorNotPermitsNil() {
        let result = Validator.and(.max(1), .not(.nil)).validate(value)
        
        #expect(result.isFailure == true)
        #expect(result.description == "no validation performed and is nil")
      }

      @Test("validate should fail when first validator permits nil and second validator pass")
      func validateFirstValidatorPremitsNilPassSecondValidatorPass() {
        let result = Validator.and(.nil, .stub(true)).validate(value)

        #expect(result.isFailure == true)
        #expect(result.description == "no validation performed")
      }

      @Test("validate should fail when first validator validator pass and second validator permits nil")
      func validateFirstValidatorPassSecondValidatorPremitsNil() {
        let result = Validator.and(.stub(true), .nil).validate(value)
        
        #expect(result.isFailure == true)
        #expect(result.description == "no validation performed")
      }
    }

    @Suite("when value is not nil")
    struct whenValueIsNotNil {

      var value: Int? = 1

      @Test("validate should fail when first validator premits nil and second validator pass")
      func validateFirstValidatorPremitsNilPassSecondValidatorPass() {
        let result = Validator.and(.nil, .stub(true)).validate(value)

        #expect(result.isFailure == true)
        #expect(result.description == "is not nil")
      }

      @Test("validate should fail when first validator pass and second validator premits nil")
      func validateFirstValidatorPassSecondValidatorPremitsNil() {
        let result = Validator.and(.stub(true), .nil).validate(value)
        
        #expect(result.isFailure == true)
        #expect(result.description == "is not nil")
      }

      @Test("validate should pass when first validator not premits nil and second validator pass")
      func validateFirstValidatorNonPremitsNilPassSecondValidatorPass() {
        let result = Validator.and(.not(.nil), .stub(true)).validate(value)

        #expect(result.isFailure == false)
        #expect(result.description == "is not nil and success description")
      }

      @Test("validate should pass when first validator pass and second validator not premits nil")
      func validateFirstValidatorPassSecondValidatorNonPremitsNil() {
        let result = Validator.and(.stub(true), .not(.nil)).validate(value)
        
        #expect(result.isFailure == false)
        #expect(result.description == "success description and is not nil")
      }
    }
  }
}

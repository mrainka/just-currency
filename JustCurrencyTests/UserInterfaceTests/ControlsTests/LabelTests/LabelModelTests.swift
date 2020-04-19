//
//  LabelModelTests.swift
//  JustCurrencyTests
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

@testable import JustCurrency
import Nimble
import XCTest

final class LabelModelTests: XCTestCase {

    func testShouldBeHiddenWhenCreatedWithEmptyText() throws {
        expect(LabelModel("").isHidden).to(beTrue())
    }

    func testShouldBeHiddenWhenCreatedWithoutText() throws {
        expect(LabelModel(nil).isHidden).to(beTrue())
    }

    func testShouldNotBeHiddenWhenCreatedWithNonEmptyText() throws {
        expect(LabelModel("any").isHidden).to(beFalse())
    }
}

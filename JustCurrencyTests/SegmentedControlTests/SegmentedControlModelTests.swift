//
//  SegmentedControlModelTests.swift
//  JustCurrencyTests
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

@testable import JustCurrency
import Nimble
import XCTest

final class SegmentedControlModelTests: XCTestCase {

    func testSelectedItemShouldRemainSelectedWhenClicked() throws {
        let control = SegmentedControlModel(items: ["a"], selectedItem: "a")
        control.items.first { $0.title == "a" }?.clicked()
        expect(control.items.first { $0.title == "a" }?.isSelected).to(beTrue())
    }

    func testShouldDeselectItemWhenAnotherWasClicked() throws {
        let control = SegmentedControlModel(items: ["a", "b"], selectedItem: "a")
        control.items.first { $0.title == "b" }?.clicked()
        expect(control.items.first { $0.title == "a" }?.isSelected).to(beFalse())
    }

    func testShouldSelectItemWhenClicked() throws {
        let control = SegmentedControlModel(items: ["a", "b"], selectedItem: "a")
        control.items.first { $0.title == "b" }?.clicked()
        expect(control.items.first { $0.title == "b" }?.isSelected).to(beTrue())
    }
}

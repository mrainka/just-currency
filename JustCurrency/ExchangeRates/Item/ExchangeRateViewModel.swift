//
//  ExchangeRateViewModel.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import Foundation

final class ExchangeRateViewModel {

    static let cellReuseIdentifier = "ExchangeRateCell"

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    var onClicked: ((ExchangeRate) -> Void)?

    private let rate: ExchangeRate

    // MARK: - Labels

    let averageRate: LabelModel
    let purchaseRate: LabelModel
    let sellingRate: LabelModel

    let code: LabelModel

    let effectiveDate: LabelModel
    let tradingDate: LabelModel

    let name: LabelModel

    // MARK: -

    init(_ rate: ExchangeRate, table: ExchangeRateTable? = nil) {
        averageRate = Self.createRate("Average", value: rate.averageRate)
        purchaseRate = Self.createRate("Purchase", value: rate.purchaseRate)
        sellingRate = Self.createRate("Selling", value: rate.sellingRate)

        code = .init(rate.code)

        effectiveDate = Self.createDate("Effective", from: rate.effectiveDate ?? table?.effectiveDate)
        tradingDate = Self.createDate("Trading", from: table?.tradingDate)

        name = .init(rate.name)

        self.rate = rate
    }

    func clicked() {
        onClicked?(rate)
    }

    // MARK: - Creating the Labels

    private static func createDate(_ name: String, from date: Date?) -> LabelModel {
        guard let date = date else { return .init(nil) }
        return .init(name + " Date: \(dateFormatter.string(from: date))")
    }

    private static func createRate(_ name: String, value: Double?) -> LabelModel {
        guard let value = value else { return .init(nil) }
        return .init(name + " Rate: \(value)")
    }
}

extension ExchangeRateViewModel: CellReusable {}

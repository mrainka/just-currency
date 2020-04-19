//
//  UITableViewCellRegisteringAndDequeuing.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func dequeueReusableCell(with item: CellReusable, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCell(withIdentifier: type(of: item).cellReuseIdentifier, for: indexPath)
    }

    func register<CellType: UITableViewCell>(_ cellClass: CellType.Type)
        where CellType: ConfigurableWithModel, CellType.ModelType: CellReusable
    {
        register(cellClass, forCellReuseIdentifier: CellType.ModelType.cellReuseIdentifier)
    }
}

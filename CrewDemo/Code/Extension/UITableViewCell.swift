//
//  UITableViewCell.swift
//  CrewDemo
//
//  Created by Wasim on 14/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}
extension UIViewController {
    class var identifier: String {
        return String(describing: self)
    }
}

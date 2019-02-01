//
//  SafeAreaHelper.swift
//  ConstraintDSL
//
//  Created by fadi on 2/2/19.
//

import UIKit

public extension UIView {
    @available(iOS 9.0, *)
    public var safeAreaHelper: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide
        } else {
            return layoutMarginsGuide
        }
    }
}

//
//  UIKitConstraints.swift
//  ConstraintDSL
//
//  Created by fadi on 1/30/19.
//

import UIKit

public protocol UIKitConstraint: LeftHandSide {
}

public struct Constraint: UIKitConstraint {
    public let view: UIView
    public let attribute: NSLayoutAttribute
}

public struct MarginableConstraint: UIKitConstraint {
    public let constraint: Constraint
    let marginedAttribute: NSLayoutAttribute

    @available(iOS 8.0, *)
    fileprivate var margined: Constraint { return Constraint(view: constraint.view,
                                                             attribute: marginedAttribute) }
    public var view: Constraint.T { return constraint.view }
    public var attribute: Constraint.U { return constraint.attribute }
}

public extension UIView {
    public var topConstraint: MarginableConstraint {
        if #available(iOS 8.0, *) {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .top),
                                        marginedAttribute: .topMargin)
        } else {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .top),
                                        marginedAttribute: .top)
        }
    }

    public var bottomConstraint: MarginableConstraint {
        if #available(iOS 8.0, *) {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .bottom),
                                        marginedAttribute: .bottomMargin)
        } else {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .bottom),
                                        marginedAttribute: .bottom)
        }
    }

    public var leftConstraint: MarginableConstraint {
        if #available(iOS 8.0, *) {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .left),
                                        marginedAttribute: .leftMargin)
        } else {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .left),
                                        marginedAttribute: .left)
        }
    }

    public var rightConstraint: MarginableConstraint {
        if #available(iOS 8.0, *) {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .right),
                                        marginedAttribute: .rightMargin)
        } else {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .right),
                                        marginedAttribute: .right)
        }
    }

    public var leadingConstraint: MarginableConstraint {
        if #available(iOS 8.0, *) {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .leading),
                                        marginedAttribute: .leadingMargin)
        } else {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .leading),
                                        marginedAttribute: .leading)
        }
    }

    public var trailingConstraint: MarginableConstraint {
        if #available(iOS 8.0, *) {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .trailing),
                                        marginedAttribute: .trailingMargin)
        } else {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .trailing),
                                        marginedAttribute: .trailing)
        }
    }

    public var centerXConstraint: MarginableConstraint {
        if #available(iOS 8.0, *) {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .centerX),
                                        marginedAttribute: .centerXWithinMargins)
        } else {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .centerX),
                                        marginedAttribute: .centerX)
        }
    }

    public var centerYConstraint: MarginableConstraint {
        if #available(iOS 8.0, *) {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .centerY),
                                        marginedAttribute: .centerYWithinMargins)
        } else {
            return MarginableConstraint(constraint: Constraint(view: self, attribute: .centerY),
                                        marginedAttribute: .centerY)
        }
    }

    public var widthConstraint: Constraint {
        return Constraint(view: self, attribute: .width)
    }

    public var heightConstraint: Constraint {
        return Constraint(view: self, attribute: .height)
    }

    public var lastBaselineConstraint: Constraint {
        return Constraint(view: self, attribute: .lastBaseline)
    }

    @available(iOS 8.0, *)
    public var firstBaselineConstraint: Constraint {
        return Constraint(view: self, attribute: .firstBaseline)
    }
}

fileprivate protocol SideInConstraintPointOfView {
    associatedtype T
    var view: T { get }
    var attribute: NSLayoutAttribute { get }
    var constant: CGFloat { get }
    var multiplier: CGFloat { get }
}

fileprivate struct LeftSideInConstriantPointOfView: SideInConstraintPointOfView {
    let view: Any
    let attribute: NSLayoutAttribute
    let constant: CGFloat
    let multiplier: CGFloat
}

fileprivate struct RightSideInConstriantPointOfView: SideInConstraintPointOfView {
    let view: Any?
    let attribute: NSLayoutAttribute
    let constant: CGFloat
    let multiplier: CGFloat
}

fileprivate func rightSide<T: RightHandSide>(side: T) -> RightSideInConstriantPointOfView {
    return RightSideInConstriantPointOfView(view: nil, attribute: .notAnAttribute,
                                            constant: side.constant, multiplier: side.multiplier)
}

fileprivate func rightSide<T: UIKitConstraint>(side: T) -> RightSideInConstriantPointOfView where T.U == NSLayoutAttribute {
    return RightSideInConstriantPointOfView(view: side.view, attribute: side.attribute, constant: side.constant, multiplier: side.multiplier)
}

fileprivate func leftSide<T: UIKitConstraint>(side: T) -> LeftSideInConstriantPointOfView where T.U == NSLayoutAttribute {
    return LeftSideInConstriantPointOfView(view: side.view, attribute: side.attribute, constant: side.constant, multiplier: side.multiplier)
}

fileprivate func uiConstraintCommon<Left: SideInConstraintPointOfView, Right: SideInConstraintPointOfView>(left: Left, right: Right) -> NSLayoutConstraint where Left.T == Any, Right.T == Any? {

    return NSLayoutConstraint.init(item: left.view, attribute: left.attribute, relatedBy: .equal, toItem: right.view, attribute: right.attribute, multiplier: right.multiplier / left.multiplier, constant: (right.constant - left.constant) / left.constant)
}

public func constraint<Left: UIKitConstraint, Right: RightHandSide>(_ equ: Equation<Left, Right>) -> NSLayoutConstraint where Left.T: UIView, Left.U == NSLayoutAttribute {

    let left = leftSide(side: equ.leftHandSide)
    let right = rightSide(side: equ.rightHandSide)

    return uiConstraintCommon(left: left, right: right)
}

public func constraint<Left: UIKitConstraint, Right: UIKitConstraint>(_ equ: EquationBothLefts<Left, Right>) -> NSLayoutConstraint where Left.T: UIView, Left.U == NSLayoutAttribute,
    Right.T: UIView, Right.U == NSLayoutAttribute {

        let left = leftSide(side: equ.leftHandSide)
        let right = rightSide(side: equ.rightHandSide)

        return uiConstraintCommon(left: left, right: right)
}


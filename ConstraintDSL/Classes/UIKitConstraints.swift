//
//  UIKitConstraints.swift
//  ConstraintDSL
//
//  Created by fadi on 1/30/19.
//

import UIKit

public protocol UIKitConstraint: LeftHandSide {
}

/// A marker interface, to mark anything constrainable, typically for `UIView` and `UILayoutGuide`
public protocol Constrainable: class {
}

extension UIView: Constrainable {
}

@available(iOS 9.0, *)
extension UILayoutGuide: Constrainable {
}

public struct Constraint<W: NSObject & Constrainable>: UIKitConstraint {
    public let view: W
    public let attribute: NSLayoutConstraint.Attribute
}

public struct MarginableConstraint<W: NSObject & Constrainable>: UIKitConstraint {
    public let constraint: Constraint<W>
    fileprivate let marginedAttribute: NSLayoutConstraint.Attribute

    @available(iOS 8.0, *)
    var margined: Constraint<W> { return Constraint<T>(view: constraint.view,
                                                       attribute: marginedAttribute) }
    public var view: W { return constraint.view }
    public var attribute: Constraint<W>.U { return constraint.attribute }
}

public extension Constrainable where Self: NSObject {
    public var topConstraint: MarginableConstraint<Self> {
        if #available(iOS 8.0, *) {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .top),
                                              marginedAttribute: .topMargin)
        } else {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .top),
                                              marginedAttribute: .top)
        }
    }

    public var bottomConstraint: MarginableConstraint<Self> {
        if #available(iOS 8.0, *) {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .bottom),
                                              marginedAttribute: .bottomMargin)
        } else {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .bottom),
                                              marginedAttribute: .bottom)
        }
    }

    public var leftConstraint: MarginableConstraint<Self> {
        if #available(iOS 8.0, *) {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .left),
                                              marginedAttribute: .leftMargin)
        } else {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .left),
                                              marginedAttribute: .left)
        }
    }

    public var rightConstraint: MarginableConstraint<Self> {
        if #available(iOS 8.0, *) {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .right),
                                              marginedAttribute: .rightMargin)
        } else {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .right),
                                              marginedAttribute: .right)
        }
    }

    public var leadingConstraint: MarginableConstraint<Self> {
        if #available(iOS 8.0, *) {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .leading),
                                              marginedAttribute: .leadingMargin)
        } else {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .leading),
                                              marginedAttribute: .leading)
        }
    }

    public var trailingConstraint: MarginableConstraint<Self> {
        if #available(iOS 8.0, *) {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .trailing),
                                              marginedAttribute: .trailingMargin)
        } else {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .trailing),
                                              marginedAttribute: .trailing)
        }
    }

    public var centerXConstraint: MarginableConstraint<Self> {
        if #available(iOS 8.0, *) {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .centerX),
                                              marginedAttribute: .centerXWithinMargins)
        } else {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .centerX),
                                              marginedAttribute: .centerX)
        }
    }

    public var centerYConstraint: MarginableConstraint<Self> {
        if #available(iOS 8.0, *) {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .centerY),
                                              marginedAttribute: .centerYWithinMargins)
        } else {
            return MarginableConstraint<Self>(constraint: Constraint<Self>(view: self, attribute: .centerY),
                                              marginedAttribute: .centerY)
        }
    }

    public var widthConstraint: Constraint<Self> {
        return Constraint<Self>(view: self, attribute: .width)
    }

    public var heightConstraint: Constraint<Self> {
        return Constraint<Self>(view: self, attribute: .height)
    }

    public var lastBaselineConstraint: Constraint<Self> {
        return Constraint<Self>(view: self, attribute: .lastBaseline)
    }

    @available(iOS 8.0, *)
    public var firstBaselineConstraint: Constraint<Self> {
        return Constraint<Self>(view: self, attribute: .firstBaseline)
    }
}

fileprivate protocol SideInConstraintPointOfView {
    associatedtype T
    var view: T { get }
    var attribute: NSLayoutConstraint.Attribute { get }
    var constant: CGFloat { get }
    var multiplier: CGFloat { get }
}

fileprivate struct LeftSideInConstriantPointOfView: SideInConstraintPointOfView {
    let view: Any
    let attribute: NSLayoutConstraint.Attribute
    let constant: CGFloat
    let multiplier: CGFloat
}

fileprivate struct RightSideInConstriantPointOfView: SideInConstraintPointOfView {
    let view: Any?
    let attribute: NSLayoutConstraint.Attribute
    let constant: CGFloat
    let multiplier: CGFloat
}

fileprivate func rightSide<T: RightHandSide>(side: T) -> RightSideInConstriantPointOfView {
    return RightSideInConstriantPointOfView(view: nil, attribute: .notAnAttribute,
                                            constant: side.constant, multiplier: side.multiplier)
}

fileprivate func rightSide<T: LeftHandSide>(side: T) -> RightSideInConstriantPointOfView where T.U == NSLayoutConstraint.Attribute, T.T: NSObject, T.T: Constrainable {
    return RightSideInConstriantPointOfView(view: side.view, attribute: side.attribute, constant: side.constant, multiplier: side.multiplier)
}

fileprivate func leftSide<T: UIKitConstraint>(side: T) -> LeftSideInConstriantPointOfView where T.U == NSLayoutConstraint.Attribute {
    return LeftSideInConstriantPointOfView(view: side.view, attribute: side.attribute, constant: side.constant, multiplier: side.multiplier)
}

fileprivate func uiConstraintCommon<Left: SideInConstraintPointOfView, Right: SideInConstraintPointOfView>(left: Left, right: Right) -> NSLayoutConstraint where Left.T == Any, Right.T == Any? {
    return NSLayoutConstraint(item: left.view, attribute: left.attribute, relatedBy: .equal, toItem: right.view, attribute: right.attribute, multiplier: right.multiplier / left.multiplier, constant: (right.constant - left.constant) / left.multiplier)
}

public func ====<T: UIKitConstraint, U: LeftHandSide>(_ lhs: T, _ rhs: U) -> NSLayoutConstraint where T.U == NSLayoutConstraint.Attribute, U.U == NSLayoutConstraint.Attribute, U.T: NSObject, U.T: Constrainable {
    let left = leftSide(side: lhs)
    let right = rightSide(side: rhs)

    return uiConstraintCommon(left: left, right: right)
}

public func ====<T: UIKitConstraint, U: RightHandSide>(_ lhs: T, _ rhs: U) -> NSLayoutConstraint where T.U == NSLayoutConstraint.Attribute {
    let left = leftSide(side: lhs)
    let right = rightSide(side: rhs)

    return uiConstraintCommon(left: left, right: right)
}

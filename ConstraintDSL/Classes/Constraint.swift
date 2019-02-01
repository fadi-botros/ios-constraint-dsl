//public protocol Attribute {
//
//}
//
//public protocol Constrainable {
//    var constant: Float { get }
//    var multiplier: Float { get }
//}
//
//public extension Constrainable {
//    var constant: Float { get { return 0.0 } }
//    var multiplier: Float { get { return 1.0 } }
//}
//
//public protocol ConstrainableView: Constrainable {
//    associatedtype Attr: Attribute
//    var parameterInNative: Any { get }
//}
//
//public protocol NotAnAttributeConstrainableView: Constrainable {
//
//}
//
//public protocol ConstrainableParameter: Constrainable {
//    associatedtype ConstrainableClass: ConstrainableView
//    var view: ConstrainableClass? { get }
//    var attribute: ConstrainableClass.Attr { get }
//}
//
//public struct ConstraintDescription<T: Constrainable, U: Constrainable> {
//    public let leftHandSide: T
//    public let rightHandSide: U
//}
//
//public struct ConstrainableParameterWithConstants<T: ConstrainableParameter>: ConstrainableParameter {
//    let base: T
//    public let constant: Float
//    public let multiplier: Float
//
//    public var view: T.ConstrainableClass? { return base.view }
//    public var attribute: T.ConstrainableClass.Attr { return base.attribute }
//}
//
//fileprivate struct EmptyConstraintable: Constrainable {
//}
//
//extension Float: Constrainable {
//    fileprivate var view: EmptyConstraintable? { return nil }
//    public var constant: Float { return self }
//    public var multiplier: Float { return 0.0 }
//}
//
//public func *<T: ConstrainableParameter>(_ constrainable: T, _ constant: Float)
//    -> ConstrainableParameterWithConstants<T> {
//    return ConstrainableParameterWithConstants<T>.init(base: constrainable, constant: constrainable.constant * constant, multiplier: constrainable.multiplier * constant)
//}
//
//public func +<T: ConstrainableParameter>(_ constrainable: T, _ constant: Float)
//    -> ConstrainableParameterWithConstants<T> {
//    return ConstrainableParameterWithConstants<T>.init(base: constrainable, constant: constrainable.constant + constant, multiplier: constrainable.multiplier)
//}
//
//struct
//
//infix operator ====
//
//func ====<T: ConstrainableParameter, U: ConstrainableParameter>(_ lhs: T, _ ths: U) -> String where T: NotAnAttributeConstrainableView {
//
//}

public protocol RightHandSide {
    var constant: CGFloat { get }
    var multiplier: CGFloat { get }
}

public extension RightHandSide {
    public var constant: CGFloat { get { return 0.0 } }
    public var multiplier: CGFloat { get { return 1.0 } }
}

public protocol LeftHandSide {
    associatedtype T
    associatedtype U
    var view: T { get }
    var attribute: U { get }
    var constant: CGFloat { get }
    var multiplier: CGFloat { get }
}

public extension LeftHandSide {
    public var constant: CGFloat { get { return 0.0 } }
    public var multiplier: CGFloat { get { return 1.0 } }
}

public struct Equation<T: LeftHandSide, U: RightHandSide> {
    public let leftHandSide: T
    public let rightHandSide: U
}

public struct EquationBothLefts<T: LeftHandSide, U: LeftHandSide> {
    public let leftHandSide: T
    public let rightHandSide: U
}

extension Double: RightHandSide {
    public var constant: CGFloat { return CGFloat(self) }
    public var multiplier: CGFloat { return 0 }
}

public struct LeftHandSideImpl<P: LeftHandSide>: LeftHandSide {
    public let leftHandSide: P
    public let constant: CGFloat
    public let multiplier: CGFloat

    public var view: P.T { return leftHandSide.view }
    public var attribute: P.U { return leftHandSide.attribute }
}

public func *<T: LeftHandSide>(_ lhs: T, _ rhs: Double) -> LeftHandSideImpl<T> {
    return LeftHandSideImpl(leftHandSide: lhs,
                            constant: lhs.constant * CGFloat(rhs),
                            multiplier: lhs.multiplier * CGFloat(rhs))
}

public func +<T: LeftHandSide>(_ lhs: T, _ rhs: Double) -> LeftHandSideImpl<T> {
    return LeftHandSideImpl(leftHandSide: lhs,
                            constant: lhs.constant + CGFloat(rhs),
                            multiplier: lhs.multiplier)
}

infix operator ====: AssignmentPrecedence

public func ====<T: LeftHandSide, U: LeftHandSide>(_ lhs: T, _ rhs: U) -> EquationBothLefts<T, U> {
    return EquationBothLefts(leftHandSide: lhs, rightHandSide: rhs)
}

public func ====<T: LeftHandSide, U: RightHandSide>(_ lhs: T, _ rhs: U) -> Equation<T, U> {
    return Equation(leftHandSide: lhs, rightHandSide: rhs)
}

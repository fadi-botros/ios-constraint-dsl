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

public func -<T: LeftHandSide>(_ lhs: T, _ rhs: Double) -> LeftHandSideImpl<T> {
    return LeftHandSideImpl(leftHandSide: lhs,
                            constant: lhs.constant - CGFloat(rhs),
                            multiplier: lhs.multiplier)
}

infix operator ====: AssignmentPrecedence
infix operator >===: AssignmentPrecedence
infix operator <===: AssignmentPrecedence


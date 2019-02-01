// https://github.com/Quick/Quick

import UIKit
import Quick
import Nimble
import ConstraintDSL

fileprivate class FakeView: LeftHandSide {
    let view: String
    let attribute: String

    init(view: String, attribute: String = "") {
        self.view = view
        self.attribute = attribute
    }

    var description: String {
        return view
    }
}

extension FakeView {
    var topConstraint: FakeView { return FakeView(view: self.view, attribute: "TopConstraint") }
    var heightConstraint: FakeView { return FakeView(view: self.view, attribute: "HeightConstraint") }
    var widthConstraint: FakeView { return FakeView(view: self.view, attribute: "WidthConstraint") }
}

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("Constraint DSL") {
            context("Simple views") {
                let superView = FakeView(view: "Superview")
                let leftSubview = FakeView(view: "Leftview")
                let rightSubview = FakeView(view: "Rightview")
                it("Simple constraints") {

                    let constraint1 =
                        superView.topConstraint ==== (leftSubview.topConstraint + 10)

                    let constraint2 =
                        leftSubview.heightConstraint ==== 64

                    let constraint3 =
                        leftSubview.widthConstraint ==== ((rightSubview.widthConstraint * 2) + -10)

                    expect(constraint1.leftHandSide.view).to(equal("Superview"))
                    expect(constraint2.leftHandSide.view).to(equal("Leftview"))
                    expect(constraint3.leftHandSide.view).to(equal("Leftview"))
                    expect(constraint1.rightHandSide.view).to(equal("Leftview"))
//                    expect(constraint2.rightHandSide.view).to(equal("Leftview"))
                    expect(constraint3.rightHandSide.view).to(equal("Rightview"))
                    expect(constraint1.leftHandSide.constant).to(equal(0))
                    expect(constraint2.leftHandSide.constant).to(equal(0))
                    expect(constraint3.leftHandSide.constant).to(equal(0))
                    expect(constraint1.leftHandSide.multiplier).to(equal(1))
                    expect(constraint2.leftHandSide.multiplier).to(equal(1))
                    expect(constraint3.leftHandSide.multiplier).to(equal(1))
                    expect(constraint1.rightHandSide.constant).to(equal(10))
                    expect(constraint2.rightHandSide.constant).to(equal(64))
                    expect(constraint3.rightHandSide.constant).to(equal(-10))
                    expect(constraint1.rightHandSide.multiplier).to(equal(1))
                    expect(constraint2.rightHandSide.multiplier).to(equal(0))
                    expect(constraint3.rightHandSide.multiplier).to(equal(2))

//                    expect((constraints[0].leftHandSide.view as? FakeView)?.description).to(equal("Superview"))
//                    expect((constraints[1].leftHandSide.view as? FakeView)?.description).to(equal("Leftview"))
//                    expect((constraints[2].leftHandSide.view as? FakeView)?.description).to(equal("Leftview"))
//                    expect((constraints[0].rightHandSide.view as? FakeView)?.description).to(equal("Leftview"))
//                    expect((constraints[1].rightHandSide.view as? FakeView)?.description).to(equal(nil))
//                    expect((constraints[2].rightHandSide.view as? FakeView)?.description).to(equal("Rightview"))
//                    expect(constraints[0].leftHandSide.topConstraint)
//                    expect(constraints[0].rightHandSide.constant).to(equal(10))
//                    expect(constraints[1].rightHandSide.constant).to(equal(64))
//                    expect(constraints[2].rightHandSide.constant).to(equal(-10))
//                    expect(constraints[0].rightHandSide.multiplier).to(equal(1))
//                    expect(constraints[1].rightHandSide.multiplier).to(equal(1))
//                    expect(constraints[2].rightHandSide.multiplier).to(equal(2))
                }
            }
        }
    }
}

class UIKitConstraintSpec: QuickSpec {
    override func spec() {
        describe("UI Kit tests") {
            let superView = UIView()
            let leftView = UIView()
            let rightView = UIView()
            superView.addSubview(leftView)
            superView.addSubview(rightView)
            context("Constraint creation") {
                let constraints: [NSLayoutConstraint] = [
                    constraint( superView.topConstraint ==== (leftView.topConstraint + 10) ),
                    constraint( superView.leftConstraint ==== (leftView.leftConstraint + 10) ),
                    constraint( superView.rightConstraint ==== (rightView.rightConstraint + 10) ),
                    constraint( rightView.rightConstraint ==== (leftView.leftConstraint + 5) ),
                    constraint( leftView.widthConstraint ==== (rightView.widthConstraint * 2) + 5 ),
                    constraint( superView.widthConstraint ==== 250)
                ]
                it("Makes good equality") {
                    expect(constraints[0].firstItem as? UIView).to(equal(superView))
                    expect(constraints[0].firstAttribute).to(equal(.top))
                    expect(constraints[0].secondItem as? UIView).to(equal(leftView))
                    expect(constraints[0].secondAttribute).to(equal(.top))
                    expect(constraints[0].constant).to(equal(10))
                    expect(constraints[0].multiplier).to(equal(1))

                    expect(constraints[1].firstItem as? UIView).to(equal(superView))
                    expect(constraints[1].firstAttribute).to(equal(.left))
                    expect(constraints[1].secondItem as? UIView).to(equal(leftView))
                    expect(constraints[1].secondAttribute).to(equal(.left))
                    expect(constraints[1].constant).to(equal(10))
                    expect(constraints[1].multiplier).to(equal(1))

                    expect(constraints[2].firstItem as? UIView).to(equal(superView))
                    expect(constraints[2].firstAttribute).to(equal(.right))
                    expect(constraints[2].secondItem as? UIView).to(equal(rightView))
                    expect(constraints[2].secondAttribute).to(equal(.right))
                    expect(constraints[2].constant).to(equal(10))
                    expect(constraints[2].multiplier).to(equal(1))

                    expect(constraints[3].firstItem as? UIView).to(equal(rightView))
                    expect(constraints[3].firstAttribute).to(equal(.right))
                    expect(constraints[3].secondItem as? UIView).to(equal(leftView))
                    expect(constraints[3].secondAttribute).to(equal(.left))
                    expect(constraints[3].constant).to(equal(5))
                    expect(constraints[3].multiplier).to(equal(1))

                    expect(constraints[4].firstItem as? UIView).to(equal(leftView))
                    expect(constraints[4].firstAttribute).to(equal(.width))
                    expect(constraints[4].secondItem as? UIView).to(equal(rightView))
                    expect(constraints[4].secondAttribute).to(equal(.width))
                    expect(constraints[4].constant).to(equal(5))
                    expect(constraints[4].multiplier).to(equal(2))

                    expect(constraints[5].firstItem as? UIView).to(equal(superView))
                    expect(constraints[5].firstAttribute).to(equal(.width))
                    expect(constraints[5].secondItem).to(beNil())
                    expect(constraints[5].secondAttribute).to(equal(.notAnAttribute))
                    expect(constraints[5].constant).to(equal(5))
                    expect(constraints[5].multiplier).to(equal(0))
                }
            }
        }
    }
}

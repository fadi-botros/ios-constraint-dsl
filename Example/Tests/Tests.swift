// https://github.com/Quick/Quick

import UIKit
import Quick
import Nimble
import ConstraintDSL

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
                    superView.topConstraint ==== (leftView.topConstraint + 10),
                    superView.leftConstraint ==== (leftView.leftConstraint + 10),
                    superView.rightConstraint ==== (rightView.rightConstraint + 10),
                    rightView.rightConstraint ==== (leftView.leftConstraint + 5),
                    leftView.widthConstraint ==== (rightView.widthConstraint * 2) + 5,
                    superView.widthConstraint ==== 250
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
                    expect(constraints[5].constant).to(equal(250.0))
                    expect(constraints[5].multiplier).to(equal(1.0))
                }
            }
        }
    }
}

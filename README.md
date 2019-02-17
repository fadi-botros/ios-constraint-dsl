# ConstraintDSL

[![CI Status](https://img.shields.io/travis/fadi-botros/ConstraintDSL.svg?style=flat)](https://travis-ci.org/fadi-botros/ConstraintDSL)
[![Version](https://img.shields.io/cocoapods/v/ConstraintDSL.svg?style=flat)](https://cocoapods.org/pods/ConstraintDSL)
[![License](https://img.shields.io/cocoapods/l/ConstraintDSL.svg?style=flat)](https://cocoapods.org/pods/ConstraintDSL)
[![Platform](https://img.shields.io/cocoapods/p/ConstraintDSL.svg?style=flat)](https://cocoapods.org/pods/ConstraintDSL)

This library is about changing your programmatic constraints from something like:

```swift
NSLayoutConstraint(item: left.view, attribute: left.attribute, relatedBy: .equal,
                   toItem: right.view, attribute: right.attribute,
                   multiplier: multiplier, constant: constant)
```

into just:

```swift
left.attributeConstraint ==== (right.attributeConstraint * multiplier) + constant
```

## Example:

```swift
// Center the text field in the view called superView
textField.centerXConstraint.margined ==== superview.centerXConstraint.margined
textField.centerYConstraint.margined ==== superview.centerYConstraint.margined

// Ensure there is at least 16 pts as a space between the top of the text field and the superView
textField.topConstraint >=== superview.topConstraint + 16
```

---

Available attributes:

- `topConstraint` :  Equivalent to `NSLayoutConstraint.top`
- `topConstraint.margined` :  Equivalent to `NSLayoutConstraint.topMargin`
- `bottomConstraint`: Equivalent to `NSLayoutConstraint.bottom` 
- `bottomConstraint.margined`: Equivalent to `NSLayoutConstraint.bottomMargin` 
- `leadingConstraint`: Equivalent to `NSLayoutConstraint.leading` 
- `leadingConstraint.margined`: Equivalent to `NSLayoutConstraint.leadingMargin` 
- `trailingConstraint`: Equivalent to `NSLayoutConstraint.trailing` 
- `trailingConstraint.margined`: Equivalent to `NSLayoutConstraint.trailingMargin` 
- `centerXConstraint`: Equivalent to `NSLayoutConstraint.centerX` 
- `centerXConstraint.margined`: Equivalent to `NSLayoutConstraint.centerXWithMargins` 
- `centerYConstraint`: Equivalent to `NSLayoutConstraint.centerY` 
- `centerYConstraint.margined`: Equivalent to `NSLayoutConstraint.centerYWithMargins` 
- `widthConstraint`: Equivalent to `NSLayoutConstraint.width` 
- `heightConstraint`: Equivalent to `NSLayoutConstraint.height` 
- `lastBaselineConstraint`: Equivalent to `NSLayoutConstraint.lastBaseline` 
- `firstBaselineConstraint`: Equivalent to `NSLayoutConstraint.firstBaseline` 

Not recommended (unless you **want not locale aware** constraints):

- `leftConstraint`: Equivalent to `NSLayoutConstraint.left` 
- `leftConstraint.margined`: Equivalent to `NSLayoutConstraint.leftMargin` 
- `rightConstraint`: Equivalent to `NSLayoutConstraint.right` 
- `rightConstraint.margined`: Equivalent to `NSLayoutConstraint.rightMargin` 


### N.B:
 - Margined constraints and lastBaseline constraints are for only iOS 8.0 or later
 
### N.B:
 - There is a tiny helper extension for any view called `safeAreaHelper` that returns the safe area layout guides if available (iOS is 11.0 or later), and returns layout margins guides if iOS 9.0 or later but earlier than 11.0.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

ConstraintDSL is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ConstraintDSL'
```

## Release notes

 - 0.1.0: Initial release
 - 0.2.0: 
   * Added `<===` and `>===` operators, which makes the `.lessThanOrEqual` and `.greaterThanOrEqual` inequalities.
   * Made the left hand side also an equation, so that something like that possible:
```swift
   view.widthConstraint * 2 ==== superView.widthConstraint
```

## Author

fadi-botros, botros_fadi@yahoo.com

## License

ConstraintDSL is available under the MIT license. See the LICENSE file for more info.

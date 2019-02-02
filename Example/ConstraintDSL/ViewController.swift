//
//  ViewController.swift
//  ConstraintDSL
//
//  Created by fadi-botros on 01/26/2019.
//  Copyright (c) 2019 fadi-botros. All rights reserved.
//

import UIKit
import ConstraintDSL

class ViewController: UIViewController {

    override func loadView() {
        let label = UILabel(frame: CGRect.zero)
        let textFieldLogin = UITextField(frame: CGRect.zero)
        let textFieldPassword = UITextField(frame: CGRect.zero)
        let labelLogin = UILabel(frame: CGRect.zero)
        let labelPassword = UILabel(frame: CGRect.zero)
        let innerView = UIView(frame: CGRect.zero)
        let button = UIButton(frame: CGRect.zero)

        let safeAreaLabel = UILabel(frame: CGRect.zero)

        let view = UIView(frame: CGRect.zero)

        [label, innerView, button, safeAreaLabel].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }

        [textFieldLogin, textFieldPassword, labelLogin, labelPassword].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            innerView.addSubview(subView)
        }

        [textFieldLogin, textFieldPassword].forEach { textField in
            textField.borderStyle = UITextBorderStyle.roundedRect
        }
        textFieldLogin.placeholder = "Login"
        textFieldPassword.placeholder = "Password"
        textFieldPassword.isSecureTextEntry = true
        button.setTitle("Start", for: .normal)
        label.text = "Enter your data"
        labelLogin.text = "Name: "
        labelPassword.text = "Password: "

        safeAreaLabel.text = "Safe area label"

        innerView.backgroundColor = UIColor.cyan

        button.setTitleColor(.blue, for: .normal)

        let constraints = [
            safeAreaLabel.centerXConstraint ==== view.centerXConstraint,
            safeAreaLabel.topConstraint ==== view.safeAreaHelper.topConstraint + 16,

            view.centerXConstraint ==== innerView.centerXConstraint,
            view.centerYConstraint ==== innerView.centerYConstraint,
            label.centerXConstraint ==== innerView.centerXConstraint,
            label.bottomConstraint + 16 ==== innerView.topConstraint,
            labelLogin.topConstraint - 16 ==== innerView.topConstraint,
            labelPassword.bottomConstraint ==== innerView.bottomConstraint - 16,
            labelLogin.leadingConstraint ==== innerView.leadingConstraint + 16,
            labelPassword.leadingConstraint ==== innerView.leadingConstraint + 16,
            textFieldLogin.trailingConstraint ==== innerView.trailingConstraint - 16,
            textFieldPassword.trailingConstraint ==== innerView.trailingConstraint - 16,
            labelLogin.widthConstraint * 2 ==== textFieldLogin.widthConstraint + 16,
            labelLogin.bottomConstraint ==== labelPassword.topConstraint - 32,
            labelLogin.trailingConstraint ==== textFieldLogin.leadingConstraint - 16,
            labelLogin.centerYConstraint ==== textFieldLogin.centerYConstraint,
            labelPassword.centerYConstraint ==== textFieldPassword.centerYConstraint,
            labelPassword.trailingConstraint ==== textFieldPassword.leadingConstraint - 16,
            button.topConstraint ==== innerView.bottomConstraint + 32,
            button.centerXConstraint ==== innerView.centerXConstraint
        ]

        constraints.forEach { $0.isActive = true }
        view.backgroundColor = UIColor.white
        self.view = view
    }

}


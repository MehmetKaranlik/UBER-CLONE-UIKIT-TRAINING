//
//  RegisterController.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 14.04.2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class RegisterViewController : UIViewController {
 // MARK:  properties
let service = RegisterService()

 private let headerLabel : UILabel = {
  let label = CustomLabel.makeSimpleLabel( labelText: "Register", labelColor: .lightGray, topography: .largeTitle)
  return label
 }()

 private lazy var navigateToLoginButton : UIButton = {
  var title : AttributedString = AttributedString()
  var uncoloredTitle : AttributedString = AttributedString("Already have an account ?")
  uncoloredTitle.foregroundColor = UIColor.darkGray
  var coloredTitle : AttributedString = AttributedString("Log-in!")
  coloredTitle.foregroundColor = UIColor.systemBlue
  title.append(uncoloredTitle)
  title.append(coloredTitle)

  let button = UIButton(type: .custom)
  button.configuration = UIButton.Configuration.borderless()
  button.configuration?.attributedTitle?.append(uncoloredTitle)
  button.configuration?.attributedTitle = title
  button.addTarget(self, action: #selector(navigateBack), for: .touchDown)
  return button
 }()

 private lazy var emailContainerView : UIView = {
  let containerView = UIView()
  let imageView = UIImageView()
  imageView.image = UIImage(named: "ic_mail_outline_white_2x")
  containerView.addSubview(imageView)
  imageView.alpha = 0.87
  imageView.anchor(left:containerView.leftAnchor,  paddingLeft: 8, width: 32, height: 32)
  imageView.centerY(inView: containerView)
  containerView.addSubview(emailTextField)
  emailTextField.centerY(inView: containerView)
  emailTextField.anchor(top:containerView.topAnchor ,bottom: containerView.bottomAnchor , right:containerView.rightAnchor , left: imageView.rightAnchor,paddingTop: 8, paddingBottom: 8, paddingLeft: 8)

  let seperatorView = UIView()
  seperatorView.backgroundColor = .lightGray
  containerView.addSubview(seperatorView)
  seperatorView.anchor(top:emailTextField.bottomAnchor,  right: containerView.rightAnchor, left: containerView.leftAnchor, paddingTop: 16, paddingBottom: 0, paddingRight: 8, paddingLeft: 8, height: 0.75)
  return containerView
 }()

 let emailTextField : UITextField = {
  let tf = CustomTextField.makeSimpleTextField(textColor: UIColor.white, textFont: .body, capitalizationStyle: Optional.none, placeholderText: "Email", placeholderTextColor: UIColor.lightGray, isSecure: false)
  return tf
 }()

 let passwordTextField : UITextField = {
  let tf = CustomTextField.makeSimpleTextField(textColor: UIColor.white, textFont: .body, capitalizationStyle: Optional.none, placeholderText: "Password", placeholderTextColor: UIColor.lightGray, isSecure: true)
  return tf
 }()

 private lazy var passwordContainerView : UIView = {
  let containerView = UIView()
  let imageView = UIImageView()
  imageView.image = UIImage(named: "ic_lock_outline_white_2x")
  containerView.addSubview(imageView)
  imageView.alpha = 0.87
  imageView.anchor(left:containerView.leftAnchor,  paddingLeft: 8, width: 32, height: 32)
  imageView.centerY(inView: containerView)
  containerView.addSubview(passwordTextField)
  passwordTextField.centerY(inView: containerView)
  passwordTextField.anchor(top:containerView.topAnchor ,bottom: containerView.bottomAnchor , right:containerView.rightAnchor , left: imageView.rightAnchor,paddingTop: 8, paddingBottom: 8, paddingLeft: 8)

  let seperatorView = UIView()
  seperatorView.backgroundColor = .lightGray
  containerView.addSubview(seperatorView)
  seperatorView.anchor(top:passwordTextField.bottomAnchor,  right: containerView.rightAnchor, left: containerView.leftAnchor, paddingTop: 16, paddingBottom: 0, paddingRight: 8, paddingLeft: 8, height: 0.75)
  return containerView
 }()

 lazy var pickerContainerView : UIView = {
  let containerView = UIView()
  let imageView = UIImageView()
  imageView.image = .init(named: "ic_account_box_white_2x")
  imageView.alpha = 0.87
  containerView.addSubview(imageView)
  imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, paddingTop: 8, paddingBottom: 8, paddingRight: 8, paddingLeft: 8, width: 32, height: 32)
  containerView.addSubview(segmentedController)
  segmentedController.anchor(top: imageView.bottomAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, left: containerView.leftAnchor, paddingTop: 8, paddingBottom: 8, paddingRight: 8, paddingLeft: 8, height: 30)
  return containerView
 }()

 let seperatorView : UIView = {
  let seperatorView = UIView()
  seperatorView.backgroundColor = .lightGray
  return seperatorView
 }()

 let segmentedController : UISegmentedControl = {
  let segmentedController = UISegmentedControl(items: ["Driver","Rider"])
  return segmentedController
 }()

 let registerButton : UIButton = {
  let button = UIButton(type: .custom)
  button.configuration = UIButton.Configuration.filled()
  button.configuration?.cornerStyle = .capsule
  button.setTitle("Sign Up", for: [])
  button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)

  return button
 }()


  // MARK:  Selectors

@objc func navigateBack() {
  self.navigationController?.popViewController(animated: true)
 }

 @objc func handleRegister() {
  guard let email = emailTextField.text else { return }
  guard let password = passwordTextField.text else { return }
  let userType = getUserType(index: segmentedController.selectedSegmentIndex)
  service.registerUser(email: email, password: password, userType: userType)
 }

 override func viewDidLoad() {
  view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
  makeHeaderLabel()
  makeGoToLoginButton()
  makeEmailContainerView()
  makePasswordContainerView()
  makePickerContainerView()
  makeSeparetorView()
  view.addSubview(registerButton)
  registerButton.anchor(top: seperatorView.bottomAnchor,right: view.rightAnchor, left: view.leftAnchor, paddingTop: 32, paddingBottom: 0, paddingRight: 24, paddingLeft: 24, height: 40)
 }

 // MARK:  Makers

 fileprivate func makeHeaderLabel() {
  view.addSubview(headerLabel)
  headerLabel.centerX(inView: view)
  headerLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
 }
 fileprivate func makeGoToLoginButton() {
  view.addSubview(navigateToLoginButton)
  navigateToLoginButton.centerX(inView: view)
  navigateToLoginButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
 }

 fileprivate func makeEmailContainerView() {
  view.addSubview(emailContainerView)
  emailContainerView.anchor(top: headerLabel.bottomAnchor, right: view.rightAnchor, left: view.leftAnchor, paddingTop: 40, paddingBottom: 0, paddingRight: 16, paddingLeft: 16, height: 40)
 }

 fileprivate func makePasswordContainerView() {
  view.addSubview(passwordContainerView)
  passwordContainerView.anchor(top: emailContainerView.bottomAnchor,right: view.rightAnchor, left: view.leftAnchor, paddingTop: 40, paddingBottom: 0, paddingRight: 16, paddingLeft: 16, height: 40)
 }

 fileprivate func makePickerContainerView() {
  view.addSubview(pickerContainerView)
  pickerContainerView.anchor(top: passwordContainerView.bottomAnchor,right: view.rightAnchor, left: view.leftAnchor, paddingTop: 32, paddingBottom: 8, paddingRight: 16, paddingLeft: 16, height: 85)
 }

 fileprivate func makeSeparetorView() {
  view.addSubview(seperatorView)
  seperatorView.anchor(top: pickerContainerView.bottomAnchor,  right: view.rightAnchor, left: view.leftAnchor, paddingTop: 16, paddingBottom: 0, paddingRight: 24, paddingLeft: 24, height: 0.75)
 }



}




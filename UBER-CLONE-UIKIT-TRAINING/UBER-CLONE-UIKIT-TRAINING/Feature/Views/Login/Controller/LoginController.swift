 //
 //  LoginController.swift
 //  UBER-CLONE-UIKIT-TRAINING
 //
 //  Created by mehmet karanlık on 13.04.2022.
 //

import Foundation
import UIKit


class LoginController : UIViewController {
  // MARK:  properties

 let service : LoginService = LoginService()


 private let headerLabel : UILabel = {
  let label = CustomLabel.makeSimpleLabel( labelText: "UBER", labelColor: .lightGray, topography: .largeTitle)
  return label
 }()

 private let emailTextField :UITextField = {
  var tf = CustomTextField
   .makeSimpleTextField(
    textColor: UIColor.white,
    textFont: .body,
    capitalizationStyle: Optional.none,
    placeholderText: "Email")
  return tf
 }()

 private lazy var passwordContainerView : UIView! = {
  var containerView = UIView()
  let imageView = UIImageView()
  imageView.image = UIImage.init(imageLiteralResourceName: "ic_account_box_white_2x")
  imageView.alpha = 0.87
  containerView.addSubview(imageView)
  imageView.centerY(inView: containerView)
  imageView.anchor(left:containerView.leftAnchor,  paddingLeft: 8, width: 32, height: 32)


  containerView.addSubview(passwordTextField)
  passwordTextField.centerY(inView: containerView)
  passwordTextField.anchor(top:containerView.topAnchor ,bottom: containerView.bottomAnchor , right:containerView.rightAnchor , left: imageView.rightAnchor,paddingTop: 8, paddingBottom: 8, paddingLeft: 8)

  let separetorView = UIView()
  containerView.addSubview(separetorView)
  separetorView.backgroundColor = .lightGray
  separetorView.anchor(top: passwordTextField.bottomAnchor,  right: containerView.rightAnchor, left: containerView.leftAnchor, paddingTop: 14, paddingBottom: 0, paddingRight: 8, paddingLeft: 8, height: 0.75)

  return containerView
 }()

 private let passwordTextField : UITextField = {
  var tf = CustomTextField
   .makeSimpleTextField(
    textColor: UIColor.white,
    textFont: .body,
    capitalizationStyle: Optional.none,
    placeholderText: "Password",
    isSecure: true
   )
  return tf
 }()


 private lazy var emailContainerView : UIView! = {
  var containerView = UIView()
  let imageView = UIImageView()
  imageView.image = UIImage.init(imageLiteralResourceName: "ic_mail_outline_white_2x")
  imageView.alpha = 0.87
  containerView.addSubview(imageView)
  imageView.centerY(inView: containerView)
  imageView.anchor(left:containerView.leftAnchor,  paddingLeft: 8, width: 32, height: 32)


  containerView.addSubview(emailTextField)
  emailTextField.centerY(inView: containerView)
  emailTextField.anchor(top:containerView.topAnchor ,bottom: containerView.bottomAnchor , right:containerView.rightAnchor , left: imageView.rightAnchor,paddingTop: 8, paddingBottom: 8, paddingLeft: 8)

  let separetorView = UIView()
  containerView.addSubview(separetorView)
  separetorView.backgroundColor = .lightGray
  separetorView.anchor(top: emailTextField.bottomAnchor,  right: containerView.rightAnchor, left: containerView.leftAnchor, paddingTop: 14, paddingBottom: 0, paddingRight: 8, paddingLeft: 8, height: 0.75)

  return containerView
 }()

 private lazy var loginButton : UIButton = {
  let button = UIButton(type: .custom)
  button.layer.cornerRadius = 20
  button.configuration = UIButton.Configuration.filled()
  button.configuration?.cornerStyle = .capsule
  button.setTitle("Login", for: [])
  button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)

  return button

 }()

 private lazy var navigateToRegisterButton : UIButton = {
  var title : AttributedString = AttributedString()
  var uncoloredTitle : AttributedString = AttributedString("Dont have account ?")
  uncoloredTitle.foregroundColor = UIColor.darkGray
  var coloredTitle : AttributedString = AttributedString(" Sign-Up!")
  coloredTitle.foregroundColor = UIColor.systemBlue
  title.append(uncoloredTitle)
  title.append(coloredTitle)

  let button = UIButton(type: .custom)
  button.configuration = UIButton.Configuration.borderless()
  button.configuration?.attributedTitle?.append(uncoloredTitle)
  button.configuration?.attributedTitle = title
  button.addTarget(self, action: #selector(navigate), for: .touchDown)
  return button
 }()


  @objc func navigate() {
   print("123")
  self.navigationController?.pushViewController(RegisterViewController(), animated: true)
 }

 @objc func handleLogin() {
  guard let email = emailTextField.text else { return }
  guard let password = passwordTextField.text else { return }
  service.loginUser(email: email, password: password) {
   print("logged in")
  }
 }

 



 override func viewDidLoad() {
  super.viewDidLoad()
  view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
  self.navigationController?.navigationBar.isHidden = true


  makeLabel()
  makeEmailContainerView()
  makePasswordContainerView()
  makeLoginButton()
  makeGoToRegisterButton()








 }


  // MARK:  MAKERS

 override var preferredStatusBarStyle: UIStatusBarStyle {
  return .lightContent
 }


 fileprivate func makeLabel() {
  view.addSubview(headerLabel)
  labelConfiguration(containerView: view)
 }
 fileprivate func labelConfiguration(containerView : UIView) {
  containerView.addSubview(headerLabel)
  headerLabel.anchor(top: containerView.safeAreaLayoutGuide.topAnchor)
  headerLabel.centerX(inView: containerView)
 }

 fileprivate func makeEmailContainerView() {
  view.addSubview(emailContainerView)
  emailContainerView.anchor(top: headerLabel.bottomAnchor,
                            right: view.rightAnchor,
                            left: view.leftAnchor,
                            paddingTop: 40,
                            paddingRight: 16,
                            paddingLeft: 16,
                            height: 40
  )
 }

 fileprivate func makePasswordContainerView() {
  view.addSubview(passwordContainerView)
  passwordContainerView.anchor(top: emailContainerView.bottomAnchor,
                               right: view.rightAnchor,
                               left: view.leftAnchor,
                               paddingTop: 40,
                               paddingRight: 16,
                               paddingLeft: 16,
                               height: 40)
 }

 fileprivate func makeLoginButton() {
  view.addSubview(loginButton)
  loginButton.anchor(
   top: passwordContainerView.bottomAnchor,right: view.rightAnchor, left: view.leftAnchor, paddingTop: 40, paddingBottom: 0, paddingRight: 16, paddingLeft: 16,height: 40)
 }

 fileprivate func makeGoToRegisterButton() {
  view.addSubview(navigateToRegisterButton)
  navigateToRegisterButton.centerX(inView: view)
  navigateToRegisterButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
 }
}













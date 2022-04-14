//
//  RegisterController.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 14.04.2022.
//

import Foundation
import UIKit


class RegisterViewController : UIViewController {
 // MARK:  properties
 
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
  return containerView
 }()

 

  // MARK:  Selectors

@objc func navigateBack() {
  self.navigationController?.popViewController(animated: true)
 }


 override func viewDidLoad() {
  view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
  makeHeaderLabel()
  makeGoToLoginButton()
  makeEmailContainerView()
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



}




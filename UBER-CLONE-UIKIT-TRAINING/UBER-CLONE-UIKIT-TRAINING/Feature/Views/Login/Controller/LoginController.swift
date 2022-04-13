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




 let headerLabel : UILabel = {
  let label = CustomLabel.makeSimpleLabel( labelText: "UBER", labelColor: .lightGray, topography: .largeTitle)
  return label
 }()

 private let emailTextField :UITextField = {
  var tf = UITextField()
  tf.borderStyle = .none
  tf.keyboardAppearance = .dark
  tf.autocapitalizationType = .none
  tf.placeholder = "E-mail"
  tf.textColor = .white
  tf.font = UIFont.systemFont(ofSize: 16)
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













 override func viewDidLoad() {
  super.viewDidLoad()
  view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
  makeLabel()
  makeEmailContainerView()













 }
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
}













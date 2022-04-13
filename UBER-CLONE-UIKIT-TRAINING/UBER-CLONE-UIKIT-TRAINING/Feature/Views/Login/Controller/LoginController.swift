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





 override func viewDidLoad() {
  super.viewDidLoad()
  view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
  makeHeaderText(
   pioneerView : CustomLabel.makeSimpleLabel( labelText: "UBER", labelColor: .lightGray, topography: .largeTitle),
   targetView: view)
  makeUserNameField(pioneerView: CustomStack.makeSimpleHStack(children: [UI]), targetView: <#T##UIView#>, containerView: <#T##UIView#>)








 }
 override var preferredStatusBarStyle: UIStatusBarStyle {
  return .lightContent
 }
}



func makeHeaderText(pioneerView:UILabel,targetView:UIView) -> Void {
 targetView.addSubview(pioneerView)
 pioneerView.anchor(top: targetView.safeAreaLayoutGuide.topAnchor)
 pioneerView.centerX(inView: targetView)
}

func makeUserNameField(pioneerView:UIView,targetView:UIView,containerView: UIView) -> Void {
 containerView.addSubview(pioneerView)
 pioneerView.anchor(top: targetView.bottomAnchor,left: targetView.leadingAnchor, paddingLeft: 16)




}
		



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


 private let headerText: UILabel = {
  let label = UILabel()
  label.textColor = .white
  label.text = "UBER"
  label.font = UIFont(name: "Avenir-Light", size: 36)
  return label
 }()


 override func viewDidLoad() {
  super.viewDidLoad()
  view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
  configureHeaderText(pioneerView : headerText,targetView: view)








 }
 override var preferredStatusBarStyle: UIStatusBarStyle {
  return .lightContent
 }
}



func configureHeaderText(pioneerView:UILabel,targetView:UIView) -> Void {
 targetView.addSubview(pioneerView)
 pioneerView.anchor(top: targetView.safeAreaLayoutGuide.topAnchor)
 pioneerView.centerX(inView: targetView)

}




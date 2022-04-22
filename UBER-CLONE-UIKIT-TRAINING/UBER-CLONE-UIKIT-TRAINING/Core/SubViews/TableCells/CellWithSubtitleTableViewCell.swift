 //
 //  CellWithSubtitleTableViewCell.swift
 //  UBER-CLONE-UIKIT-TRAINING
 //
 //  Created by mehmet karanlık on 16.04.2022.
 //

import UIKit
import MapKit

let locationReuseIdentifier = "LocationCell"

class CellWithSubtitleTableViewCell: UITableViewCell {

 var placemark : MKPlacemark? {
  didSet {
   titleLabel.text = placemark?.name
   if let subtitle = placemark?.returnAddress() {
    subtitleLabel.text = subtitle
   }else {
    subtitleLabel.text = ""
   }
  }
 }




  // MARK:  Properties

 private let titleLabel : UILabel = {
  let label = UILabel()
  label.font =  .systemFont(ofSize: 14)
  label.text = "123 Main Street"
  return label
 }()


 private let subtitleLabel : UILabel = {
  let label = UILabel()
  label.font =  .systemFont(ofSize: 14)
  label.textColor = .lightGray
  label.text = "123 Main Street LA"
  return label
 }()


  // MARK:  Lifecycle

 override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
  super.init(style: style, reuseIdentifier: reuseIdentifier)
  let stack = UIStackView(arrangedSubviews: [titleLabel,subtitleLabel])
  stack.axis = .vertical
  stack.distribution = .fillEqually
  stack.spacing = 4

  addSubview(stack)
  stack.centerY(inView: self)
  stack.anchor(left: self.leftAnchor, paddingTop: 6, paddingBottom: 0, paddingRight: 0, paddingLeft: 12)
 }

 required init?(coder: NSCoder) {
  fatalError("BLA BLA")
 }

}

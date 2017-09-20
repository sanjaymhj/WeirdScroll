//
//  EditableInfoCardCell.swift
//  Patient Engagement
//
//  Created by Saugat Gautam on 5/12/17.
//  Copyright © 2017 Leapfrog. All rights reserved.
//

import UIKit

protocol TestCellDelegate: class {
    func didBeginEditing(textField: UITextField, cell: UITableViewCell)
    func shouldBeginEditing(textField: UITextField, cell: UITableViewCell) -> Bool
    func didEndEditing(textField: UITextField, cell: UITableViewCell)
}

class TestCell: UITableViewCell {

  @IBOutlet var mainLabel: UILabel!
  @IBOutlet var textField: UITextField!
  
  var delegate: TestCellDelegate?
    
  override func awakeFromNib() {
    super.awakeFromNib()
    textField.delegate = self
  }
  
}

extension TestCell: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    delegate?.didEndEditing(textField: textField, cell: self)
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    return delegate?.shouldBeginEditing(textField: textField, cell: self) ?? false
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    delegate?.didBeginEditing(textField: textField, cell: self)
  }
  
}

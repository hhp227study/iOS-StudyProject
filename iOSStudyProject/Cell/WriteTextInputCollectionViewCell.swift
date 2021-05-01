//
//  WriteTextInputCollectionViewCell.swift
//  iOSStudyProject
//
//  Created by 홍희표 on 2021/04/30.
//

import UIKit

class WriteTextInputCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    
    @IBOutlet weak var valueTextView: UITextView!
    
    var inputItem: WriteTextInput? = nil
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let input = inputItem {
            keyLabel.text = input.key
            valueTextView.placeholder = input.value
        }
    }
}

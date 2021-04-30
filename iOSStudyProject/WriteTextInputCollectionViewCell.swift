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
    
    var inputItem: WriteTextInput? = nil /*{
        didSet {
            print("DEBUG : \(oldValue)")
            configure()
        }
     // raywenderlich
    }*/
    
    override func awakeFromNib() {
        if let input = inputItem {
            keyLabel.text = input.key
            valueTextView.text = input.value
            
            layoutSubviews()
        }
    }
    
    private func configure() {
        guard let inputItem = inputItem else { return }
        
        keyLabel.text = inputItem.key
        valueTextView.text = inputItem.value
    }
}

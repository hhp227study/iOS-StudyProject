//
//  WriteImageInputCollectionViewCell.swift
//  iOSStudyProject
//
//  Created by 홍희표 on 2021/05/01.
//

import UIKit

class WriteImageInputCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var keyLabel: UILabel!
    
    @IBOutlet weak var valueImageView: UIImageView!
    
    var inputItem: WriteImageInput? = nil
    
    var imageTapDelegateFunc: (() -> Void)? = nil
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let input = inputItem {
            keyLabel.text = input.key
            valueImageView.image = input.value
            
            valueImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionImageTap)))
        }
    }
    
    @objc func actionImageTap() {
        if let imageClick = imageTapDelegateFunc {
            imageClick()
        }
    }
}

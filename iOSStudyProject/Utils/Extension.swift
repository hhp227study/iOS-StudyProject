//
//  Extension.swift
//  iOSStudyProject
//
//  Created by 홍희표 on 2021/05/01.
//

import UIKit
 
extension UITextView: UITextViewDelegate {
    @IBInspectable var placeholder: String? {
        get {
            guard let placeholderLabel = viewWithTag(100) as? UILabel else {
                return nil
            }
            return placeholderLabel.text
        }
        set {
            if let placeholderLabel = viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                
                placeholderLabel.sizeToFit()
            } else {
                let placeholderLabel = UILabel()
                placeholderLabel.text = newValue
                placeholderLabel.font = font
                placeholderLabel.textColor = UIColor.lightGray
                placeholderLabel.tag = 100
                placeholderLabel.isHidden = !text.isEmpty
                delegate = self
                
                placeholderLabel.sizeToFit()
                addSubview(placeholderLabel)
                if let placeholderLabel = viewWithTag(100) as! UILabel? {
                    let labelX = textContainer.lineFragmentPadding
                    let labelY = textContainerInset.top
                    let labelWidth = frame.width - (labelX * 2)
                    let labelHeight = placeholderLabel.frame.height
                    placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
                }
            }
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
}

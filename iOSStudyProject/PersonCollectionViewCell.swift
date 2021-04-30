//
//  PersonCollectionViewCell.swift
//  iOSStudyProject
//
//  Created by 홍희표 on 2021/04/30.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var personItem: Person? = nil {
        didSet {
            print("DEBUG : \(oldValue)")
        }
    }
    
//
//    init() {
//        super.init()
//        print("DEBUG : test")
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        print("DEBUG : ")
        if let person = personItem {
            nameLabel.text = person.name
            positionLabel.text = person.position.joined(separator: ", ")
        }
    }
}

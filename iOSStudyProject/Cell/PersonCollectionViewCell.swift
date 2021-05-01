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
    
    var personItem: Person? = nil
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let person = personItem {
            nameLabel.text = person.name
            positionLabel.text = person.position.joined(separator: ", ")
            emailLabel.text = person.email
            bioLabel.text = person.bio
            
            DispatchQueue.main.async {
                self.profileImageView.image = try? UIImage(data: Data(contentsOf: person.photo!))
            }
        }
    }
}

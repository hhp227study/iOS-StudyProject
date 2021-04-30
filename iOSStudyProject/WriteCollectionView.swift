//
//  WriteCollectionView.swift
//  iOSStudyProject
//
//  Created by 홍희표 on 2021/04/30.
//

import UIKit

class WriteViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data = [WriteTextInput.init(key: "Name", value: ""), WriteTextInput.init(key: "Email", value: ""), WriteTextInput.init(key: "Position", value: "")]
    
    
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension WriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("test")
    }
}

extension WriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "textInputCell", for: indexPath) as? WriteTextInputCollectionViewCell else {
                    fatalError()
                }
        print("DEBUG : Passed guard")
            print("DEBUG : \(data[indexPath.row])")
            cell.inputItem = data[indexPath.row]
        cell.backgroundColor = .systemRed
            cell.layoutSubviews()
        return cell
    }
}

extension WriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
            return CGSize(width: collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right), height: flowLayout.itemSize.height)
        }
}


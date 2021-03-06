//
//  WriteCollectionView.swift
//  iOSStudyProject
//
//  Created by 홍희표 on 2021/04/30.
//

import UIKit
import MobileCoreServices

class WriteViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [Any] = [WriteTextInput.init(key: "Name", value: "Name을 입력하세요."), WriteTextInput.init(key: "Email", value: "Email을 입력하세요."), WriteTextInput.init(key: "Position", value: "Position을 입력하세요."),WriteTextInput.init(key: "Bio", value: "Bio를 입력하세요."), WriteImageInput.init(key: "Image", value: UIImage())]
    
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func actionAdd(_ sender: UIBarButtonItem) {
        if let viewController = navigationController?.children.first as? ViewController {
            guard let name = ((collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? WriteTextInputCollectionViewCell)?.valueTextView.text), !name.isEmpty else {
                showAlert(title: "알림", message: "Name을 입력하세요.", style: .alert, UIAlertAction(title: "확인", style: .default, handler: nil))
                return
            }
            guard let email = ((collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as? WriteTextInputCollectionViewCell)?.valueTextView.text), validateEmail(email) else {
                showAlert(title: "알림", message: "올바른 Email형식이 아닙니다.", style: .alert, UIAlertAction(title: "확인", style: .default, handler: nil))
                return
            }
            guard let position = ((collectionView.cellForItem(at: IndexPath(row: 2, section: 0)) as? WriteTextInputCollectionViewCell)?.valueTextView.text), !position.isEmpty else {
                showAlert(title: "알림", message: "Position을 입력하세요.", style: .alert, UIAlertAction(title: "확인", style: .default, handler: nil))
                return
            }
            guard let bio = ((collectionView.cellForItem(at: IndexPath(row: 3, section: 0)) as? WriteTextInputCollectionViewCell)?.valueTextView.text), !bio.isEmpty else {
                showAlert(title: "알림", message: "Bio를 입력하세요.", style: .alert, UIAlertAction(title: "확인", style: .default, handler: nil))
                return
            }
            
            viewController.addData(name, bio, email, [position], "테스트블로그", nil)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(title: String?, message: String? = nil, style: UIAlertController.Style, _ actions: UIAlertAction...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
            
        actions.forEach(alert.addAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func validateEmail(_ email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
        let validationStatus = NSPredicate(format: "SELF MATCHES %@", regEx)
        return validationStatus.evaluate(with: email)
    }
}

extension WriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(data)
    }
}

extension WriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let input = data[indexPath.row] as? WriteTextInput {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "textInputCell", for: indexPath) as? WriteTextInputCollectionViewCell else {
                fatalError()
            }
            cell.inputItem = input
            
            cell.layoutSubviews()
            return cell
        } else if let input = data[indexPath.row] as? WriteImageInput {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageInputCell", for: indexPath) as? WriteImageInputCollectionViewCell else {
                fatalError()
            }
            cell.inputItem = input
            cell.imageTapDelegateFunc = {
                let imagePicker = UIImagePickerController()
                let galleryAction = UIAlertAction(title: "갤러리", style: UIAlertAction.Style.default) { _ in
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        imagePicker.delegate = self
                        imagePicker.sourceType = .photoLibrary
                        imagePicker.mediaTypes = [kUTTypeImage as String]
                        imagePicker.allowsEditing = true
                                
                        self.present(imagePicker, animated: true, completion: nil)
                    } else {
                        self.showAlert(title: "카메라 접근 불가", style: UIAlertController.Style.alert,UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                    }
                }
                let cameraAction = UIAlertAction(title: "카메라", style: UIAlertAction.Style.default) { _ in
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        imagePicker.delegate = self
                        imagePicker.sourceType = .camera
                        imagePicker.mediaTypes = [kUTTypeImage as String]
                        imagePicker.allowsEditing = true
                                
                        self.present(imagePicker, animated: true, completion: nil)
                    } else {
                        self.showAlert(title: "카메라 접근 불가", style: UIAlertController.Style.alert, UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                    }
                }
                let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
                        
                self.showAlert(title: "이미지 선택", style: UIAlertController.Style.actionSheet, galleryAction, cameraAction, cancelAction)
            }
            
            cell.layoutSubviews()
            return cell
        }
        return UICollectionViewCell()
    }
}

extension WriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        return CGSize(width: collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right), height: flowLayout.itemSize.height)
    }
}

extension WriteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
                
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            
            for i in data.indices {
                if var element = data[i] as? WriteImageInput {
                    element.value = editedImage
                    data[i] = element
                }
            }
            print(data)
            collectionView.reloadData()
            dismiss(animated: true, completion: nil)
        }
    }
}


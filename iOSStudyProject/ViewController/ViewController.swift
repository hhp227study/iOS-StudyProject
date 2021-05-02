//
//  ViewController.swift
//  iOSStudyProject
//
//  Created by 홍희표 on 2021/04/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addRefreshControl()
        fetchDataList()
        collectionView.layoutSubviews()
    }
    
    private func fetchDataList() {
        data = [Person.init(name: "홍희표", bio: "공식 Android 11이 출시되기 전 최종 업데이트인 베타 3를 이제 사용할 수 있습니다. 이제 앱이 준비되었는지 확인해 보세요. 호환성 테스트에 필요한 기술 리소스를 가져오고 사용자, 컨트롤 및 개인정보 보호를 위해 제공할 수 있는 환경을 알아보세요. 공식 Android 11이 출시되기 전 최종 업데이트인 베타 3를 이제 사용할 수 있습니다. 이제 앱이 준비되었는지 확인해 보세요. 호환성 테스트에 필요한 기술 리소스를 가져오고 사용자, 컨트롤 및 개인정보 보호를 위해 제공할 수 있는 환경을 알아보세요. 공식 Android 11이 출시되기 전 최종 업데이트인 베타 3를 이제 사용할 수 있습니다. 이제 앱이 준비되었는지 확인해 보세요. 호환성 테스트에 필요한 기술 리소스를 가져오고 사용자, 컨트롤 및 개인정보 보호를 위해 제공할 수 있는 환경을 알아보세요.", email: "Hong227@naver.com", position: ["Android", "iOS"], blog: "http://blog.naver.com/hong227", photo: URL(string: "https://cdn.pixabay.com/photo/2020/12/22/12/38/cat-5852139_1280.jpg")), Person.init(name: "김용대", bio: "Android 11의 새로운 기능과 최신 Android 개발의 기본사항 및 권장사항을 논의하는 온라인 커뮤니티 Meetup의 국제 이벤트 시리즈입니다.", email: "ydkim2110@gmail.com", position: ["Android", "iOS"], blog: "https://github.com/ydkim2110/ydkim2110.github.io.git", photo: URL(string: "https://cdn.pixabay.com/photo/2020/12/22/12/38/cat-5852139_1280.jpg")), Person.init(name: "신용훈", bio: "공식 Android 11이 출시되기 전 최종 업데이트인 베타 3를 이제 사용할 수 있습니다. 이제 앱이 준비되었는지 확인해 보세요. 호환성 테스트에 필요한 기술 리소스를 가져오고 사용자, 컨트롤 및 개인정보 보호를 위해 제공할 수 있는 환경을 알아보세요.", email: "blabla@gmail.com", position: ["iOS"], blog: "", photo: URL(string: "https://cdn.pixabay.com/photo/2020/12/22/12/38/cat-5852139_1280.jpg"))]
    }
    
    private func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refreshControlDidChangeValue), for: .valueChanged)
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
    }
    
    @objc func refreshControlDidChangeValue(refreshControl: UIRefreshControl) {
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("test")
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as? PersonCollectionViewCell else {
            fatalError()
        }
        cell.personItem = data[indexPath.row]
                
        cell.layoutSubviews()
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        return CGSize(width: collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right), height: flowLayout.itemSize.height)
    }
}

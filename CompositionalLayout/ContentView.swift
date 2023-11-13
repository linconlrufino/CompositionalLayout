//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by Linconl Rufino on 26/10/23.
//

import SwiftUI

class FoodController: UICollectionViewController {
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    private static let categoryHeaderId = "categoryHeaderId"
    
    init(){
        super.init(collectionViewLayout: FoodController.createLayout())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Create Compositional Layout
    static func createLayout() -> UICollectionViewCompositionalLayout {
       return  UICollectionViewCompositionalLayout {
            (sectionNumber, env) -> NSCollectionLayoutSection? in
            
           if sectionNumber == 0 {
               
               let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
               item.contentInsets.trailing = 2
                
               let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
               
               let section = NSCollectionLayoutSection(group: group)
           
               section.orthogonalScrollingBehavior = .paging
           
               return section
           } else if sectionNumber == 1 {
               
               let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalWidth(0.35)))
               item.contentInsets.trailing = 16
               item.contentInsets.bottom = 16

               let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
               
               let section = NSCollectionLayoutSection(group: group)
               section.contentInsets.leading = 16
               section.contentInsets.trailing = 16

               section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension:  .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .topLeading)
               ]
               
               return section
           } else if sectionNumber == 2{
               
               let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
               item.contentInsets.trailing = 32
               
               let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(125)), subitems: [item])
               
               let section = NSCollectionLayoutSection(group: group)
               section.contentInsets.leading = 16
               section.contentInsets.top = 16
               section.orthogonalScrollingBehavior = .continuous
           
               return section
           } else {
               let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(300)))
               item.contentInsets.trailing = 16
               item.contentInsets.bottom = 16
               
               let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
               
               let section = NSCollectionLayoutSection(group: group)
               section.contentInsets = .init(top: 32, leading: 16, bottom: 0, trailing: 0)
               
               return section
           }
           
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        return header
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 || section == 2 {
            return 3
        }else if section == 1 {
            return 8
        }
        
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        navigationItem.title = "Food Delivery"
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: FoodController.categoryHeaderId, withReuseIdentifier: headerId)
    }
}

class Header: UICollectionReusableView {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "Categories"
        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }

    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(
                rootViewController: FoodController()
            )
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        
        typealias UIViewControllerType = UIViewController
    }
}

struct contentView: View {
    var body: some View {
        Text("Hello World!")
    }
}

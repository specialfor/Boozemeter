//
//  DrinksViewController.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class DrinksViewController: ViewController {
    
    fileprivate let cellID: String = "DrinkCell"
    
    // MARK: Views
    lazy var collectionView: UICollectionView = {
        let side: CGFloat = 90.0
        
        let collView = UICollectionView(frame: CGRect.zero, collectionViewLayout: DrinksCollectionViewLayout(width: side, height: side))
        collView.backgroundColor = .clear
        
        collView.dataSource = self
        collView.delegate = self
        
        collView.register(DrinkCell.self, forCellWithReuseIdentifier: cellID)
        
        self.view.addSubview(collView)
        collView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        return collView
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.reloadData()
        
        navigationItem.title = "Алкоголь"
    }
    
}

// MARK: UICollectionViewDelegate
extension DrinksViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: show spreadsheet
    }
    
}

// MARK: UICollectionViewDataSource
extension DrinksViewController: UICollectionViewDataSource {

    var drinks: [Drink] {
        return Drink.drinks
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? DrinkCell {
            
            cell.setup(with: drinks[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}

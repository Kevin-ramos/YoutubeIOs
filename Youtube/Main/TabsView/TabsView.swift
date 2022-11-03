//
//  TabsView.swift
//  Youtube
//
//  Created by user228543 on 10/14/22.
//

import Foundation
import UIKit


protocol TabsViewProtocol : AnyObject{
    
    func didSelectOption(index: Int)
}

class TabsView : UIView{
    lazy var collectionView : UICollectionView = {
        // crear bar horizontal
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        // Se le asigna ese layout horizontal
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(named: "backgroundColor")
        //registrar celda
        collection.register(UINib(nibName: "\(OptionCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(OptionCell.self)")
        
        return collection
    }()
    var underline : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    var selectedItem : IndexPath = IndexPath(item: 0, section: 0)
    var leadingConstraint : NSLayoutConstraint?
    var widthConstraint : NSLayoutConstraint?
    
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        configCollectionView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private var options : [String] = []
    weak private var delegate : TabsViewProtocol?
    //patron delegate
    func buildView(delegate: TabsViewProtocol, options : [String]){
        self.delegate = delegate
        self.options = options
        collectionView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.configUnderline()
        }
       
    }
    
    private func configCollectionView(){
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),

        ])
    }
    func configUnderline(){
        addSubview(underline)
        NSLayoutConstraint.activate([
            underline.heightAnchor.constraint(equalToConstant: 2.0),
            underline.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        let currentCell = collectionView.cellForItem(at: selectedItem)!
        widthConstraint = underline.widthAnchor.constraint(equalToConstant: currentCell.frame.width)
        widthConstraint?.isActive = true
        
        leadingConstraint = underline.leadingAnchor.constraint(equalTo: currentCell.leadingAnchor)
        leadingConstraint?.isActive = true
    }
    func updateUnderline(xOrigin : CGFloat, width : CGFloat){
        widthConstraint?.constant = width
        leadingConstraint?.constant = xOrigin
        layoutIfNeeded()
    }
    
}
extension TabsView : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(OptionCell.self)", for: indexPath) as? OptionCell else{
            return UICollectionViewCell()
        }
        cell.configCell(option: options[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectOption(index: indexPath.item)
    }
    
}
extension TabsView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = options[indexPath.item]
        label.font = UIFont.systemFont(ofSize: 16)
        
        return CGSize(width: label.intrinsicContentSize.width+20 , height:frame.height)
    }
}

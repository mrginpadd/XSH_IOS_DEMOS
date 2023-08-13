////
////  WBTablePicsCollectionView.swift
////  xsh_demos
////
////  Created by xushihao on 2023/8/13.
////
//
//import Foundation
//import UIKit
//
//class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
//    // 创建一个 UICollectionView
//    var collectionView: UICollectionView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // 创建 UICollectionViewFlowLayout 实例，用于设置布局样式
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 100, height: 100) // 设置每个单元格的大小
//        layout.minimumInteritemSpacing = 10 // 设置单元格之间的最小间距
//        layout.minimumLineSpacing = 10 // 设置每行之间的最小间距
//        
//        // 创建 UICollectionView 实例，并设置代理和数据源
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        
//        // 注册自定义单元格类
//        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
//        
//        // 添加集合视图到视图层级中
//        view.addSubview(collectionView)
//    }
//    
//    // MARK: UICollectionViewDataSource
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10 // 返回集合视图中的列数
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
//        
//        // 设置单元格的内容
//        cell.titleLabel.text = "Item \(indexPath.item)"
//        
//        return cell
//    }
//    
//    // MARK: UICollectionViewDelegate
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // 单元格被选中的回调方法
//        print("Selected item at indexPath: \(indexPath)")
//    }
//}

//
//  WBTableViewController.swift
//  xsh_demos
//
//  Created by xushihao on 2023/8/13.
//

import Foundation
import UIKit
import SDWebImage

class WBTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var tableView = UITableView()
    var msgList: [WBMsgModel] = []
    let cellID = "WEBCELLID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 配置SDWebImageDownloader选项
        SDWebImageDownloader.shared.setValue("SDWebImage", forHTTPHeaderField: "User-Agent")
        SDWebImageDownloader.shared.config.downloadTimeout = 30.0
//        SDWebImageDownloader.shared.http÷
        //视图设置
        setupViews()
        
        //数据请求
        fetchData()
        

        
    }
    
    
    // MARK: - 数据请求
    
    func fetchData() {
        getMsgList()
    }
    
    func getMsgList() {
        NewWorkConfig.getMsgList { res in
            if let list = res["list"] as? [Any] {
                list.forEach({ item in
                    if let dic = item as? [String: Any] {
                        let model = WBMsgModel(dictionary: dic)
                        self.msgList.append(model)
                    }
                })
                print("拿到的结果 \(self.msgList.count)")
            } else {
                self.msgList = []
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    //MARK: - 视图设置
    
    func setupViews() {
        //设置安全区
        view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.frame = view.bounds
        //注册复用单元格
        tableView.register(WBTableCellView.self, forCellReuseIdentifier: cellID)
        
        

        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
    }
    
    //MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell = tableView.dequeueReusableCell(withIdentifier: self.cellID) as? WBTableCellView
        
        if cell == nil {
            cell = WBTableCellView(style: .default, reuseIdentifier: self.cellID)
        }
        
        if let encodedUrlString = self.msgList[indexPath.row].avatarURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let imageUrl = URL(string: encodedUrlString) {
            cell?.avatarView.sd_setImage(with: imageUrl, placeholderImage: nil, context: nil)
        }
        
        cell?.authorLabel.text = self.msgList[indexPath.row].nickname
        cell?.timeLabel.text = self.msgList[indexPath.row].timestamp
        cell?.detailLabel.text = self.msgList[indexPath.row].content
        return cell!
    }
    
}

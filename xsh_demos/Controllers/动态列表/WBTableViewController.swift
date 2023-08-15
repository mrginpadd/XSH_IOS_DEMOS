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
    lazy var footerView: UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 30))
        footerView.backgroundColor = .systemGray
        let textLabel = UILabel()
        textLabel.text = "加载更多..."
        //水平垂直居中
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.color = .red
        //指示器动画
        indicatorView.startAnimating()
        
        footerView.addSubview(textLabel)
        textLabel.mas_makeConstraints { make in
            make?.center.equalTo()(footerView)
            make?.height.equalTo()(30)
        }
        
        
        footerView.addSubview(indicatorView)
        indicatorView.mas_makeConstraints { make in
            make?.right.equalTo()(textLabel.mas_left)?.offset()(-5)
            make?.centerY.equalTo()(footerView)
        }
        return footerView
    }()
    
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
    
}

// MARK: - 数据请求
extension WBTableViewController {
    func fetchData() {
        getMsgList(completion: nil)
    }
    
    func getMsgList(completion: ((Bool) -> Void)?) {
        NewWorkConfig.getMsgList { res in
            if let list = res["list"] as? [Any] {
                list.forEach({ item in
                    if let dic = item as? [String: Any] {
                        let model = WBMsgModel(dictionary: dic)
                        self.msgList.append(model)
                    }
                })
            } else {
                self.msgList = []
            }
            
            completion?(true)
            
            self.refreshTableView()
            
        }
    }
    func loadMore() {
        self.tableView.tableFooterView = self.footerView
        // 显示加载更多的动画
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NewWorkConfig.getMsgList { res in
                if let list = res["list"] as? [Any] {
                    list.forEach({ item in
                        if let dic = item as? [String: Any] {
                            let model = WBMsgModel(dictionary: dic)
                            self.msgList.append(model)
                        }
                    })
                } else {
                    //加载失败
                }
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                }
                self.refreshTableView()

            }
        }

    }
    
    @objc func refreshData() {
        
        self.msgList.removeAll()
        getMsgList { done in
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
            }
        }
        
    }
}

//MARK: - 视图设置
extension WBTableViewController {
    
    func refreshTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
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
        
        //下拉刷新
        let refreshControl = UIRefreshControl()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.gray
        ]
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新", attributes: attributes)
        // 将指示器放在文字的左侧
        refreshControl.tintColor = .green

        // 添加下拉刷新的事件处理
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        // 将refreshControl添加到对应的ScrollView中
        tableView.refreshControl = refreshControl
        //上拉加载更多
        tableView.tableFooterView = footerView

        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
    }
}

//MARK: - UITableView Delegate
extension WBTableViewController {
    
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
        cell?.model = self.msgList[indexPath.row]


        return cell!
    }
    
    //MARK: - 上拉加载更多
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.msgList.count > 1 && indexPath.row == self.msgList.count - 1 {
            loadMore()
        }
    }
}

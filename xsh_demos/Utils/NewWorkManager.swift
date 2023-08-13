//
//  NewWorkManager.swift
//  xsh_demos
//
//  Created by xushihao on 2023/8/13.
//

import Foundation

class NewWorkConfig {
    static let baseUrl = "http://127.0.0.1:4523/m1/3147477-0-default"
    
    
    // MARK: - 接口
    static let msgList = "/weibo/msglist"
    
    // MARK: - 接口方法
    static func convertDataToDic(data: Result<Data, Error>) -> [String: Any] {
        let result: Result<Data, Error> = data // 这里是你的Result<Data, Error>对象
        switch result {
        case .success(let data):
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // 处理成功，将data解析为字典
//                    print("成功：\(json)")
                    return json
                } else {
                    print("无法将data解析为字典")
                }
            } catch {
                print("解析失败：\(error)")
            }
            
        case .failure(let error):
            // 处理失败的情况，可以使用error对象获取失败的信息
            print("失败：\(error.localizedDescription)")
        }
        return [:]
        
    }
    
    static func getMsgList(completion: @escaping ([String: Any]) -> Void) {
        NetWorkManager.shared.get(urlStr: "\(baseUrl)\(msgList)") { res in
            completion(convertDataToDic(data: res))
        }
    }
}




class NetWorkManager {
    static let shared = NetWorkManager()
    
    private init() {}
    
    func get(urlStr: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: urlStr, code: -1)))
                return
            }
            completion(.success(data))
            
        }
        task.resume()
    }
    
    func post(urlStr: String, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: urlStr, code: -1)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
        
    }
}

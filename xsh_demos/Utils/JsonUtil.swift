//
//  JsonUtil.swift
//  xsh_demos
//
//  Created by xushihao on 2023/8/13.
//

import Foundation

class JsonUtil {
    static func parseJSONString(jsonString: String) -> [String: Any]? {
        if let data = jsonString.data(using: .utf8) {
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    return jsonDictionary
                } else {
                    print("JSON 字符串解析失败")
                    return nil
                }
            } catch {
                print("JSON 解析失败：\(error.localizedDescription)")
                return nil
            }
        } else {
            print("JSON 字符串转换为 Data 失败")
            return nil
        }
    }
}

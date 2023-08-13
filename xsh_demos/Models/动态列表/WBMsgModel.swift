class WBMsgModel {
    var avatarURL: String
    var nickname: String
    var timestamp: String
    var content: String
    var images: [String]
    init(avatarURL: String, nickname: String, timestamp: String, content: String, images: [String]) {
        self.avatarURL = avatarURL
        self.nickname = nickname
        self.timestamp = timestamp
        self.content = content
        self.images = images
    }
}
extension WBMsgModel {
    convenience init(dictionary: [String: Any]) {
        var avatarURL = ""
        if let avatarURLString = dictionary["avatar_url"] as? String {
            avatarURL = avatarURLString
        }
        
        var nickname = ""
        if let nicknameString = dictionary["nickname"] as? String {
            nickname = nicknameString
        }
        
        var timestamp = ""
        if let timestampString = dictionary["timestamp"] as? String {
            timestamp = timestampString
        }
        
        var content = ""
        if let contentString = dictionary["content"] as? String {
            content = contentString
        }
        
        var images = [String]()
        if let imagesArray = dictionary["images"] as? [String] {
            images = imagesArray
        }
        
        self.init(avatarURL: avatarURL, nickname: nickname, timestamp: timestamp, content: content, images: images)
    }
}

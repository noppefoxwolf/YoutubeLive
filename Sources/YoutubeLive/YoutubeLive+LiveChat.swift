//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2020/10/06.
//

import Foundation
import Combine

///https://developers.google.com/youtube/v3/live/docs/liveChatMessages#resource
public extension YoutubeLive.Client {
    func getLiveChatMessages(
        liveChatID: String,
        part: [GetLiveChatMessages.Part] = [.id]
    ) -> AnyPublisher<GetLiveChatMessages.Response, Error> {
        self.get(path: "/liveChat/messages", queryItems: [
            .init(name: "part", value: part.map(\.rawValue).joined(separator: ",")),
            .init(name: "liveChatId", value: liveChatID)
        ])
    }
    
    enum GetLiveChatMessages {
        public enum Part: String {
            case id
            case snippet
        }
        
        public struct Response: Codable {
            public let kind: String
            public let etag: String
            public let nextPageToken: String?
            public let prevPageToken: String?
            public let pageInfo: YoutubeLive.PageInfo
            public let items: [YoutubeLive.LiveChatMessage]
        }
    }
}

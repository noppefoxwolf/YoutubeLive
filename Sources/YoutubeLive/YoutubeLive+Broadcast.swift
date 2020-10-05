//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2020/10/05.
//

import Foundation
import Combine

public extension YoutubeLive.Client {
    func getLiveBroadcasts(
        part: [GetLiveBroadcasts.Part] = [.id],
        broadcastType: GetLiveBroadcasts.BroadcastType = .persistent,
        mine: Bool = false,
        maxResults: Int = 5,
        pageToken: String? = nil
    ) -> AnyPublisher<GetLiveBroadcasts.Response, Error> {
        self.get(path: "/liveBroadcasts", queryItems: [
            .init(name: "part", value: part.map(\.rawValue).joined(separator: ",")),
            .init(name: "broadcastType", value: broadcastType.rawValue),
            .init(name: "mine", value: "\(mine)"),
            .init(name: "maxResults", value: "\(maxResults)"),
            .init(name: "pageToken", value: pageToken)
        ])
    }
    
    enum GetLiveBroadcasts {
        public enum Part: String {
            case id
            case snippet
            case contentDetails
            case status
        }
        public enum BroadcastType: String {
            case all
            case event
            case persistent
        }
        
        public struct Response: Codable {
            public let kind: String
            public let etag: String
            public let nextPageToken: String?
            public let prevPageToken: String?
            public let pageInfo: YoutubeLive.PageInfo
            public let items: [YoutubeLive.Broadcast]
        }
    }
}

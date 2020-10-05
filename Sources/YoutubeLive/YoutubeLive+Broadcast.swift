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
        filter: GetLiveBroadcasts.Filter = .mine,
        broadcastType: GetLiveBroadcasts.BroadcastType = .persistent,
        maxResults: Int = 5,
        pageToken: String? = nil
    ) -> AnyPublisher<GetLiveBroadcasts.Response, Error> {
        var queryItems: [URLQueryItem] = []
        queryItems.append(.init(name: "part", value: part.map(\.rawValue).joined(separator: ",")))
        queryItems.append(.init(name: "broadcastType", value: broadcastType.rawValue))
        queryItems.append(.init(name: "maxResults", value: "\(maxResults)"))
        queryItems.append(.init(name: "pageToken", value: pageToken))
        switch filter {
        case let .broadcastStatus(status):
            queryItems.append(.init(name: "broadcastStatus", value: status.rawValue))
        case let .id(ids):
            queryItems.append(.init(name: "id", value: ids.joined(separator: ",")))
        case .mine:
            queryItems.append(.init(name: "mine", value: "\(true)"))
        }
        
        return self.get(path: "/liveBroadcasts", queryItems: queryItems)
    }
    
    enum GetLiveBroadcasts {
        public enum Filter {
            case broadcastStatus(BroadcastStatus)
            case id([String])
            case mine
            
            public enum BroadcastStatus: String {
                case active
                case all
                case completed
                case upcoming
            }
        }
        
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

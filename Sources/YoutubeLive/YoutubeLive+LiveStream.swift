//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2020/10/06.
//
import Foundation
import Combine

///https://developers.google.com/youtube/v3/live/docs/liveStreams/list
public extension YoutubeLive.Client {
    func getLiveStreams(
        part: [GetLiveStreams.Part] = [.id],
        filter: GetLiveStreams.Filter = .mine
    ) -> AnyPublisher<GetLiveStreams.Response, Error> {
        var queryItems: [URLQueryItem] = [.init(name: "part", value: part.map(\.rawValue).joined(separator: ","))]
        switch filter {
        case let .id(ids):
            queryItems.append(.init(name: "id", value: ids.joined(separator: ",")))
        case .mine:
            queryItems.append(.init(name: "mine", value: "\(true)"))
        }
        return self.get(path: "/liveStreams", queryItems: queryItems)
    }
    
    enum GetLiveStreams {
        public enum Filter {
            case id([String])
            case mine
        }
        
        public enum Part: String {
            case id
            case snippet
            case cdn
            case status
        }
        
        public struct Response: Codable {
            public let kind: String
            public let etag: String
            public let nextPageToken: String?
            public let prevPageToken: String?
            public let pageInfo: YoutubeLive.PageInfo
            public let items: [YoutubeLive.LiveStream]
        }
    }
}

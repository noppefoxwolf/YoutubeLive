//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2020/10/06.
//
import Foundation
import Combine

public extension YoutubeLive.Client {
    func getLiveStreams(
        part: [GetLiveStreams.Part] = [.id],
        mine: Bool = false
    ) -> AnyPublisher<GetLiveStreams.Response, Error> {
        self.get(path: "/liveStreams", queryItems: [
            .init(name: "part", value: part.map(\.rawValue).joined(separator: ",")),
            .init(name: "mine", value: "\(mine)")
        ])
    }
    
    enum GetLiveStreams {
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

//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2020/10/05.
//

import Foundation

public struct YoutubeLiveError: Error, Decodable {
    public let error: YoutubeLiveError.Error
    
    public struct Error: Decodable {
        public let code: Int
        public let message: String
        public let errors: [YoutubeLiveError.Error.Error]
        public let status: String
        
        public struct Error: Decodable {
            public let message: String
            public let domain: String
            public let reason: String
            public let location: String
            public let locationType: String
        }
    }
}

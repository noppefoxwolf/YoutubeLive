//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2020/10/05.
//

import Foundation

public extension YoutubeLive {
    struct PageInfo: Codable {
        public let totalResults: Int
        public let resultsPerPage: Int
    }
    
    struct Thumbnail: Codable {
        public enum SizeKey: String, Codable {
            case `default`
            case medium
            case high
        }
        
        public let url: String
        public let width: Int
        public let height: Int
    }
    
    struct Broadcast: Codable, Identifiable {
        public let id: String
        public let kind: String
        public let etag: String
        public let snippet: Snippet?
        public let status: Status?
        public let contentDetails: ContentDetails?
        
        public struct Snippet: Codable {
            public let channelId: String
            public let publishedAt: Date
            public let title: String
            public let thumbnails: [Thumbnail.SizeKey : Thumbnail]
            public let scheduledStartTime: Date
            public let actualStartTime: Date?
            public let actualEndTime: Date?
            public let isDefaultBroadcast: Bool
            public let liveChatId: String?
        }
        
        public struct Status: Codable {
            public let lifeCycleStatus: String
            public let privacyStatus: String
            public let recordingStatus: String
            public let madeForKids: Bool
            public let selfDeclaredMadeForKids: Bool
        }
        
        public struct ContentDetails: Codable {
            public let boundStreamId: String
            public let boundStreamLastUpdateTimeMs: String //Date
            public let monitorStream: MonitorStream
            public let enableEmbed: Bool
            public let enableDvr: Bool
            public let enableContentEncryption: Bool
            public let startWithSlate: Bool
            public let recordFromStart: Bool
            public let enableClosedCaptions: Bool
            public let closedCaptionsType: String
            public let enableLowLatency: Bool
            public let latencyPreference: String
            public let projection: String
            public let enableAutoStart: Bool
            public let enableAutoStop: Bool
            
            public struct MonitorStream: Codable {
                public let enableMonitorStream: Bool
                public let broadcastStreamDelayMs: Int
                public let embedHtml: String
            }
        }
    }
    
    struct LiveStream: Codable {
        public let kind: String
        public let etag: String
        public let id: String
        public let snippet: Snippet?
        public let cdn: Cdn?
        public let status: Status?
        public let contentDetails: ContentDetails?
        
        public struct Snippet: Codable {
            let channelId: String
            let title: String
        }
        public struct Cdn: Codable {
            public let ingestionType: IngestionType
            public let ingestionInfo: IngestionInfo
            public let resolution: Resolution
            public let frameRate: FrameRate
            
            public enum IngestionType: String, Codable {
                case dash
                case hls
                case rtmp
            }
            public enum Resolution: String, Codable {
                case _240p = "240p"
                case _360p = "360p"
                case _480p = "480p"
                case _720p = "720p"
                case _1080p = "1080p"
                case _1440p = "1440p"
                case _2160p = "2160p"
                case variable
            }
            public enum FrameRate: String, Codable {
                case _30fps = "30fps"
                case _60fps = "60fps"
                case variable
            }
            public struct IngestionInfo: Codable {
                public let streamName: String
                public let ingestionAddress: String
                public let backupIngestionAddress: String
                public let rtmpsIngestionAddress: String
                public let rtmpsBackupIngestionAddress: String
            }
        }
        public struct Status: Codable {
            public let streamStatus: String
            public let healthStatus: HealthStatus
            
            public struct HealthStatus: Codable {
                public let status: String
            }
        }
        public struct ContentDetails: Codable {
            public let closedCaptionsIngestionUrl: String
            public let isReusable: Bool
        }
    }
    
    struct LiveChatMessage: Codable {
        public let kind: String
        public let etag: String
        public let id: String
        public let snippet: Snippet?
        
        public struct Snippet: Codable {
            public let type: String
            public let liveChatId: String
            public let authorChannelId: String
            public let publishedAt: String
            public let hasDisplayContent: Bool
            public let displayMessage: String
            public let textMessageDetails: TextMessageDetails
            
            public struct TextMessageDetails: Codable {
                public let messageText: String
            }
        }
    }
}

import XCTest
@testable import YoutubeLive
import Combine
import CombineExpectations

final class YoutubeLiveTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    let accessToken: String = """
    """
    lazy var client = YoutubeLive.Client(accessToken: accessToken)
    
    /// Hot test
    func testGetLiveBroadcasts() throws {
        let recorder = client.getLiveBroadcasts(mine: true).record()
        let elements = try wait(for: recorder.elements, timeout: 5.0)
        dump(elements[0])
        XCTAssertEqual(elements[0].items.count, 1)
    }
    
    /// Hot test
    func testGetLiveStreams() throws {
        let recorder = client.getLiveStreams(part: [.cdn], mine: true).record()
        let elements = try wait(for: recorder.elements, timeout: 5.0)
        dump(elements[0])
        XCTAssertEqual(elements[0].items.count, 3)
    }
    
    func testDecodeYTLStyleDate() throws {
        struct T: Decodable {
            let date: Date
        }
        let json = """
        {"date":"2020-10-03T16:44:39Z"}
        """
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let res = try decoder.decode(T.self, from: json.data(using: .utf8)!)
        print(res)
    }
    
    func xtestDecodableYTLStyleMsDate() throws {
        struct T: Decodable {
            let date: Date
        }
        let json = """
        {"date":"2020-08-08T12:40:01.204000Z"}
        """
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let res = try decoder.decode(T.self, from: json.data(using: .utf8)!)
        print(res)
    }
}

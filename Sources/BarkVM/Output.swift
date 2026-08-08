import Foundation

public protocol OutputSink: AnyObject {
    func write(_ line: String)
}

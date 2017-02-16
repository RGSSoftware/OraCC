import Moya

public enum ResponseStatusCode {
    case informational
    case success
    case redirection
    case clientError
    case serverError
    case undefined
    
    public init(statusCode: Int) {
        switch statusCode {
        case 100 ..< 200:
            self = .informational
        case 200 ..< 300:
            self = .success
        case 300 ..< 400:
            self = .redirection
        case 400 ..< 500:
            self = .clientError
        case 500 ..< 600:
            self = .serverError
        default:
            self = .undefined
        }
    }
}

public extension Response {
    public var responseStatusCode: ResponseStatusCode {
        return ResponseStatusCode(statusCode: self.statusCode)
    }
}

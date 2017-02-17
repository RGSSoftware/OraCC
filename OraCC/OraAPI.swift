import Foundation
import Moya

let endpointClosure = { (target: OraAPI) -> Endpoint<OraAPI> in
    let defaultEndpoint = RxMoyaProvider.defaultEndpointMapping(for: target)
    
    if let token = AuthenticationToken.token {
        return defaultEndpoint.adding(newHTTPHeaderFields:["Authorization": token])
    } else {
        return defaultEndpoint
    }
    
}

let OraProvider = RxMoyaProvider<OraAPI>(endpointClosure:endpointClosure)
let StubOraProvider = RxMoyaProvider<OraAPI>(endpointClosure:endpointClosure, stubClosure: MoyaProvider.delayedStub(2), plugins: [NetworkLoggerPlugin(verbose: true)])

enum OraAPI {
    case login(email: String, password: String)
    case register(name: String, email: String, password: String, passwordConfirmation: String)
    
    case chats(page: Int, pageSize: Int)
    case chatMessages(id: Int, page: Int, pageSize: Int)
}

extension OraAPI : TargetType {
    
    static var base: String { return "https://private-93240c-oracodechallenge.apiary-mock.com" }
    var baseURL: URL { return URL(string: OraAPI.base)! }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .register:
            return "/users"
        case .chats:
            return "/chats"
        case .chatMessages(let id, _, _):
            return "/chats/\(id)/chat_messages"
            
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .login(let email, let password):
            return ["email": email, "password": password]
        case .register(let name, let email, let password, let passwordConfirmation):
            return ["name": name, "email": email, "password": password, "password_confirmation": passwordConfirmation]
        case .chats(let page, let pageSize):
            return ["page": page, "limit": pageSize]
        case .chatMessages(_, let page, let pageSize):
            return ["page": page, "limit": pageSize]
        
        }
    }
    
    public var task: Task {
        return .request
    }
    
    var method: Moya.Method {
        switch self {
        case .login,
             .register:
            return .post
        case .chats,
             .chatMessages:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .login:
            return stubbedResponse("Login_Sample_Data")
        case .register:
            return stubbedResponse("Register_Sample_Data")
        case .chats:
            return stubbedResponse("Chats_Sample_Data")
        case .chatMessages:
            return stubbedResponse("ChatMessaes_Sample_Data")
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .login,
             .register:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
}

func stubbedResponse(_ filename: String) -> Data! {
    
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

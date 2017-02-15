import Foundation
import Moya

let OraProvider = RxMoyaProvider<OraAPI>()
let StubOraProvider = RxMoyaProvider<OraAPI>(stubClosure: MoyaProvider.immediatelyStub)

enum OraAPI {
    case login(email: String, password: String)
}

extension OraAPI : TargetType {
    
    static var base: String { return "https://private-93240c-oracodechallenge.apiary-mock.com" }
    var baseURL: URL { return URL(string: OraAPI.base)! }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .login(let email, let password):
            return ["email": email, "password": password]
        }
    }
    
    public var task: Task {
        return .request
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .login:
            return stubbedResponse("Login_Sample_Data")
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .login:
            return JSONEncoding.default
        }
    }
}

func stubbedResponse(_ filename: String) -> Data! {
    
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

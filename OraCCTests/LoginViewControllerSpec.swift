import Quick
import Nimble
import Nimble_Snapshots
import Moya

@testable
import OraCC

class LoginViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var subject: UINavigationController!
        
        beforeEach {
            
            let provider = StubOraProvider
            
            let lVC = R.storyboard.main.loginViewController()!
            
            lVC.provider = provider
            
            subject = UINavigationController(rootViewController: lVC)
            
        }
        
        it("looks right") {
            let sizes = ["iPhone_5": CGSize(width: 320, height: 667),
                         "iPhone_7": CGSize(width: 375, height: 667),
                         "iPhone_7_Plus": CGSize(width: 621, height: 1104),
                         "iPad_Mini": CGSize(width: 768, height: 1024),
                         "iPad_Pro": CGSize(width: 1024, height: 1366)]
            subject.loadViewProgrammatically()
//            expect(subject).to(recordDynamicSizeSnapshot(sizes: sizes))
            expect(subject).to(haveValidDynamicSizeSnapshot(sizes: sizes))
        }
    }
}

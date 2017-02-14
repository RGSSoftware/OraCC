import Quick
import Nimble

@testable
import OraCC

class AuthenticationTokenSpec: QuickSpec {
        
    override func spec() {
        
        let token = "testToken"
        
        beforeEach {
            AuthenticationToken.token = token
        }
        
        afterEach {
            AuthenticationToken.token = nil
        }
        
        describe("token"){
            it("should return correct token"){
                expect(AuthenticationToken.token).to(equal(token))
            }
            
            it("should be invalid"){
                AuthenticationToken.token = nil
                expect(AuthenticationToken.token).to(beNil())
            }
        }
    }
    
}

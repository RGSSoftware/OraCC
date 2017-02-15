import Quick
import Nimble
import Nimble_Snapshots
import Moya

@testable
import OraCC


class FormSpec: QuickSpec {
        
    override func spec() {
        
        var subject: LoginForm!
        
        beforeEach {
            subject = LoginForm()
        }
        
        describe("email"){
            it("should be me@test.com"){
                
                let email = "me@test.com"
                
                subject.field(.email)?.value = email
                
                expect(subject.field(.email)?.value).to(equal(email))
            }
        }
        
        describe("password"){
            it("should be aabbC"){
                
                let password = "aabbC"
                
                subject.field(.password)?.value = password
                
                expect(subject.field(.password)?.value).to(equal(password))
            }
        }
        
        describe("valid"){
            
            it("should be false"){
                subject.field(.email)?.value = "dd"
                subject.field(.password)?.value = ""
                
                expect(subject.isValid).to(beFalse())
                
                subject.field(.email)?.value = "fake@gmail.com"
                subject.field(.password)?.value = "ddf"
                
                expect(subject.isValid).to(beFalse())
            }
            
            it("should be true"){
                subject.field(.email)?.value = "me@test.com"
                subject.field(.password)?.value = "aabbC"
                
                expect(subject.isValid).to(beTrue())
            }
        }
    }
    
}

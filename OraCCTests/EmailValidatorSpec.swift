import Quick
import Nimble

@testable
import OraCC

class EmailValidatorSpec: QuickSpec {
    
    override func spec() {
        
        var subject: EmailValidator!
        
        beforeEach {
            subject = EmailValidator()
        }
        
        describe("valid"){
            
            it("should be false"){
                subject.value = nil
                expect(subject.isValid).to(beFalse())
                
                subject.value = "aa"
                expect(subject.isValid).to(beFalse())
                
                subject.value = ""
                expect(subject.isValid).to(beFalse())
            }
            
            it("should be true"){
                subject.value = "me@test.com"
                expect(subject.isValid).to(beTrue())
            }
        }
    }
}

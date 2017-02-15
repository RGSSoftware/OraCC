import Quick
import Nimble

@testable
import OraCC

class PasswordValidatorSpec: QuickSpec {
    
    override func spec() {
        
        var subject: PasswordValidator!
        
        beforeEach {
            subject = PasswordValidator()
        }
        
        describe("valid"){
            
            it("should be false"){
                subject.value = nil
                expect(subject.isValid).to(beFalse())
                
                subject.value = "a"
                expect(subject.isValid).to(beFalse())
                
                subject.value = ""
                expect(subject.isValid).to(beFalse())
                
                subject.value = "aabb"
                expect(subject.isValid).to(beFalse())
                
                subject.value = "aabbc"
                expect(subject.isValid).to(beFalse())
                
            }
            
            it("should be true"){
                subject.value = "aabbC"
                expect(subject.isValid).to(beTrue())
            }
        }
    }
}

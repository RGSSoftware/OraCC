import Quick
import Nimble

@testable
import OraCC

class TextValidatorSpec: QuickSpec {
    
    override func spec() {
        
        var subject: TextValidator!
        
        beforeEach {
            subject = TextValidator()
        }
        
        describe("valid"){
            
            it("should be false"){
                subject.value = nil
                expect(subject.isValid).to(beFalse())
                
                subject.value = "aabb"
                expect(subject.isValid).to(beFalse())
                
                subject.value = ""
                expect(subject.isValid).to(beFalse())
            }
            
            it("should be true"){
                subject.value = "aabbc"
                expect(subject.isValid).to(beTrue())
            }
        }
    }
}

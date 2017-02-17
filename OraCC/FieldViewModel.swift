import Foundation
import RxSwift
import NSObject_Rx

class FieldViewModel: NSObject {
    internal let field: Field
    
    var label: String{
        return field.label
    }
    
    var placeholder: String{
        return field.placeholder
    }
    
    var value = Variable<String?>(nil)
    
    init(field: Field) {
        
        self.field = field
        
        super.init()
        
        value.value = field.value
        
        self.value.asObservable().subscribe(onNext:{
            self.field.value = $0
        }).addDisposableTo(rx_disposeBag)
    }
    
    var isSecure: Bool{
        if field.fieldType == .password ||
            field.fieldType == .passwordConfirm {
            return true
        } else {
            return false
        }
    }
}

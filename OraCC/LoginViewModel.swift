import Foundation
import Moya
import RxSwift
import NSObject_Rx

class LoginViewModel: NSObject {
    internal let provider: RxMoyaProvider<OraAPI>
    
    var form = LoginForm()
    
    var numberOfFields: Int {
        return form.fields.count
    }
    
    init(provider: RxMoyaProvider<OraAPI>){
        self.provider = provider
        
        super.init()
    }
    
    func fieldAtIndexPath(_ indexPath: IndexPath) -> Field {
        return form.fields[indexPath.row]
    }
    
    func fieldViewModelForIndexPath(_ indexPath: IndexPath) -> FieldViewModel?{
        
        if indexPath.row < numberOfFields {
            return FieldViewModel(field: fieldAtIndexPath(indexPath))
        }
        
        return .none
    }

}

class FieldViewModel: NSObject {
    internal let field: Field
    
    var label: String{
        return field.label
    }
    
    var placeholder: String{
        return field.placeholder
    }
    
    var value = PublishSubject<String?>()
    
    init(field: Field) {
        
        self.field = field
        
        super.init()
        
        self.value.subscribe(onNext:{
            self.field.value = $0
        }).addDisposableTo(rx_disposeBag)
    }
}

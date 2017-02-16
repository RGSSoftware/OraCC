import Foundation
import Moya
import RxSwift
import NSObject_Rx

struct Message {
    let title: String
    let body: String?
}

class LoginViewModel: NSObject {
    internal let provider: RxMoyaProvider<OraAPI>
    
    internal let formViewModel: FormViewModel
    
    var numberOfFields: Int {
        return formViewModel.numberOfFields
    }
    
    var showMessage = PublishSubject<Message>()
    
    init(provider: RxMoyaProvider<OraAPI>){
        self.provider = provider
        
        self.formViewModel = FormViewModel(form: LoginForm())

        
        super.init()
    }
    
    func fieldViewModelForIndexPath(_ indexPath: IndexPath) -> FieldViewModel?{
        return formViewModel.fieldViewModelForIndexPath(indexPath)
    }
    
    func login() {
        if !formViewModel.form.isValid{
            if let field = formViewModel.form.firstInvalidField() {
                showMessage.onNext(Message(title: field.label, body: field.validator.errorMessage))
            }
        }
    }

}

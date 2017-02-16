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
    
    var showSpinner = PublishSubject<Bool>()
    
    var didLoginSuccessful = PublishSubject<Void>()
    
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
        
        showSpinner.onNext(true)
        
        let email = formViewModel.form.field(.email)!.value!
        let password = formViewModel.form.field(.password)!.value!
        
        provider.request(.login(email: email, password: password)).subscribe(onNext:{ [weak self] response in
            
            self?.showSpinner.onNext(false)
            
            switch response.responseStatusCode{
            case .success:
                
                if let urlResponse = response.response as? HTTPURLResponse {
                    
                    if let authorization = urlResponse.allHeaderFields["Authorization"] as? String{
                        AuthenticationToken.token = authorization
                    }
                }
                
                self?.didLoginSuccessful.onNext()
                
            case .clientError:
                self?.showMessage.onNext(Message(title: "Register Error", body: "Please check your submitted info and try again."))
            case .serverError,
                 .informational,
                 .undefined:
                self?.showMessage.onNext(Message(title: "Network Error", body: "Please try later."))
            default:()
            }
            
        }).addDisposableTo(rx_disposeBag)
    }

}

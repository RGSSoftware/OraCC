import Foundation
import Moya
import RxSwift
import NSObject_Rx

class RegisterViewModel: NSObject {
    internal let provider: RxMoyaProvider<OraAPI>
    
    internal let formViewModel: FormViewModel
    
    var numberOfFields: Int {
        return formViewModel.numberOfFields
    }
    
    var showMessage = PublishSubject<Message>()
    
    var showSpinner = PublishSubject<Bool>()
    
    var didRegisterSuccessful = PublishSubject<Void>()
    
    init(provider: RxMoyaProvider<OraAPI>){
        self.provider = provider
        self.formViewModel = FormViewModel(form: RegisterForm())
        
        super.init()
    }
    
    func fieldViewModelForIndexPath(_ indexPath: IndexPath) -> FieldViewModel?{
        return formViewModel.fieldViewModelForIndexPath(indexPath)
    }
    
    func register() {
        if !formViewModel.form.isValid{
            if let field = formViewModel.form.firstInvalidField() {
                showMessage.onNext(Message(title: field.label, body: field.validator.errorMessage))
            }
        } else {
            let password = formViewModel.form.field(.password)!.value!
            let passwordConfirm = formViewModel.form.field(.passwordConfirm)!.value!
            
            if password != passwordConfirm {
                return showMessage.onNext(Message(title: "Password Mismatch", body: nil))
            }
            
            showSpinner.onNext(true)
            
            let name = formViewModel.form.field(.name)!.value!
            let email = formViewModel.form.field(.email)!.value!
            
            provider.request(.register(name: name, email: email, password: password, passwordConfirmation: passwordConfirm)).subscribe(onNext:{ [weak self] response in
                
                self?.showSpinner.onNext(false)
                
                switch response.responseStatusCode{
                case .success:
                    
                    if let urlResponse = response.response as? HTTPURLResponse {
                        
                        if let authorization = urlResponse.allHeaderFields["Authorization"] as? String{
                            AuthenticationToken.token = authorization
                        }
                    }
                    
                    self?.didRegisterSuccessful.onNext()
                    
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
}

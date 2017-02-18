import Foundation
import Moya
import RxSwift
import NSObject_Rx

class LoginViewModel: NSObject {
    internal let provider: RxMoyaProvider<OraAPI>
    
    internal let formViewModel: FormViewModel
    
    var numberOfFields: Int {
        return formViewModel.numberOfFields
    }
    
    var showMessage = PublishSubject<Message>()
    
    var showSpinner = PublishSubject<Bool>()
    
    var shouldReload = PublishSubject<Void>()
    
    var didLoginSuccessful = PublishSubject<Void>()
    
    init(provider: RxMoyaProvider<OraAPI>){
        self.provider = provider
        
        self.formViewModel = FormViewModel(form: LoginForm())

        
        super.init()
    }
    
    func clearForm() {
        formViewModel.form.fields.forEach{$0.value = nil}
        shouldReload.onNext()
    }
    
    func fieldViewModelForIndexPath(_ indexPath: IndexPath) -> FieldViewModel?{
        return formViewModel.fieldViewModelForIndexPath(indexPath)
    }
    
    func login() {
        if !formViewModel.form.isValid{
            if let field = formViewModel.form.firstInvalidField() {
                return showMessage.onNext(Message(title: field.label, body: field.validator.errorMessage))
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
                
                do {
                    let json = try response.mapJSON() as? [String: Any]
                    let data = json?["data"] as? [String: Any]
                    
                    if let data = data {
                        let user = User.fromJSON(data)
                        User.setCurrentUser(user)
                        self?.didLoginSuccessful.onNext()
                    } else {
                        self?.showMessage.onNext(Message.networkError())
                    }
                    
                } catch {
                    self?.showMessage.onNext(Message.networkError())
                }
                
            case .clientError:
                self?.showMessage.onNext(Message.loginError())
            case .serverError,
                 .informational,
                 .undefined:
                self?.showMessage.onNext(Message.networkError())
            default:()
            }
            
        }, onError:{ [weak self] error in
            guard let strongSelf = self else { return }
            
            strongSelf.showSpinner.onNext(false)
            
            strongSelf.showMessage.onNext(Message.networkError())
                
        }).addDisposableTo(rx_disposeBag)
    }

}

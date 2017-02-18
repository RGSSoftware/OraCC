import Foundation
import Moya
import RxSwift
import NSObject_Rx

class AccountViewModel: NSObject {
    internal let provider: RxMoyaProvider<OraAPI>
    
    internal let formViewModel: FormViewModel
    internal let user: User
    
    var numberOfFields: Int {
        return formViewModel.numberOfFields
    }
    
    var showMessage = PublishSubject<Message>()
    
    var showSpinner = PublishSubject<Bool>()
    
    var didSaveSuccessful = PublishSubject<Void>()
    
    init(provider: RxMoyaProvider<OraAPI>, user: User){
        self.provider = provider
        
        self.user = user
        self.formViewModel = FormViewModel(form: AccountForm())
    
        super.init()
        
        addUserToForm(user)
    }
    
    func addUserToForm(_ user: User) {
        formViewModel.form.field(.name)?.value = user.name
        formViewModel.form.field(.email)?.value = user.email
        formViewModel.form.field(.password)?.value = "aaaaaa"
        formViewModel.form.field(.passwordConfirm)?.value = "aaaaaa"
    }
    
    func fieldViewModelForIndexPath(_ indexPath: IndexPath) -> FieldViewModel?{
        let viewModel = formViewModel.fieldViewModelForIndexPath(indexPath)
        return viewModel
    }
    
    func save() {
        if !formViewModel.form.isValid{
            if let field = formViewModel.form.firstInvalidField() {
                return showMessage.onNext(Message(title: field.label, body: field.validator.errorMessage))
            }
        }
        
        let password = formViewModel.form.field(.password)!.value!
        let passwordConfirm = formViewModel.form.field(.passwordConfirm)!.value!
        
        if password != passwordConfirm {
            return showMessage.onNext(Message(title: "Password Mismatch", body: nil))
        }
        
        showSpinner.onNext(true)
        
        let name = formViewModel.form.field(.name)!.value!
        let email = formViewModel.form.field(.email)!.value!
        
        provider.request(.updateMe(name: name, email: email, password: password, passwordConfirmation: passwordConfirm)).subscribe(onNext:{ [weak self] response in
            
            self?.showSpinner.onNext(false)
            
            switch response.responseStatusCode{
            case .success:
                
                do {
                    let json = try response.mapJSON() as? [String: Any]
                    let data = json?["data"] as? [String: Any]
                    
                    if let data = data {
                        let user = User.fromJSON(data)
                        User.setCurrentUser(user)
                        self?.addUserToForm(user)
                        self?.didSaveSuccessful.onNext()
                    } else {
                        self?.showMessage.onNext(Message.networkError())
                    }
                    
                } catch {
                    self?.showMessage.onNext(Message.networkError())
                }
                
            case .clientError:
                self?.showMessage.onNext(Message.saveFormError())
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

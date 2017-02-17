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
        
        formViewModel.form.field(.name)?.value = user.name
        formViewModel.form.field(.email)?.value = user.email
        formViewModel.form.field(.password)?.value = "aaaaaa"
        formViewModel.form.field(.passwordConfirm)?.value = "aaaaaa"
        
        super.init()
    }
    
    func fieldViewModelForIndexPath(_ indexPath: IndexPath) -> FieldViewModel?{
        let viewModel = formViewModel.fieldViewModelForIndexPath(indexPath)
        return viewModel
    }
    
    func save() {
        if !formViewModel.form.isValid{
            if let field = formViewModel.form.firstInvalidField() {
                showMessage.onNext(Message(title: field.label, body: field.validator.errorMessage))
            }
        }
        
        let password = formViewModel.form.field(.password)!.value!
        let passwordConfirm = formViewModel.form.field(.passwordConfirm)!.value!
        
        if password != passwordConfirm {
            return showMessage.onNext(Message(title: "Password Mismatch", body: nil))
        }
    }
    
}

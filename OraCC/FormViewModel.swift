import Foundation

struct FormViewModel {
    var form: FormRepresentable
    
    var numberOfFields: Int {
        return form.fields.count
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

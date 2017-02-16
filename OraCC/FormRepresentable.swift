import Foundation

enum FieldType {
    case email
    case password
    case text
    case passwordConfirm
}

protocol FormRepresentable {
    var fields: [Field] { get set }
    
    var isValid: Bool { get }
    
    func firstInvalidField() -> Field?
    
    func field(_ type: FieldType) -> Field?
}

extension FormRepresentable{
    
    var isValid: Bool {
        return fields.map{$0.validator.isValid}.reduceAnd()
    }
    
    func firstInvalidField() -> Field? {
        return fields.filter{ $0.validator.isValid == false }.first
    }
    
    func field(_ type: FieldType) -> Field? {
        return fields.filter{ $0.fieldType == type }.first
    }
}

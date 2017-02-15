import Foundation

class Field {
    let label: String
    let placeholder: String
    let fieldType: FieldType
    
    var value: String? {
        didSet {
            validator.value = value
        }
    }
    var validator: Validator
    
    init(label: String, placeholder: String, value: String? = nil, fieldType: FieldType, validator: Validator) {
        self.label = label
        self.placeholder = placeholder
        self.value = value
        self.fieldType = fieldType
        self.validator = validator
    }
}

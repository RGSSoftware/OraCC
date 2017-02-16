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
    var validator: ValidatorRepresentable
    
    init(label: String, placeholder: String, value: String? = nil, fieldType: FieldType, validator: ValidatorRepresentable) {
        self.label = label
        self.placeholder = placeholder
        self.value = value
        self.fieldType = fieldType
        self.validator = validator
    }
}

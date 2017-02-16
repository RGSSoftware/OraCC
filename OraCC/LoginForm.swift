import Foundation

enum FieldType {
    case email
    case password
    case text
    case passwordConfirm
}

struct LoginForm {
     var fields: [Field]
    
    init(){
        fields = [Field(label: "Email", placeholder: "Your Email", fieldType: .email, validator: EmailValidator()),
                  Field(label: "Password", placeholder: "Your Password", fieldType: .password,validator: PasswordValidator())
        ]
    }
    
    var isValid: Bool {
        return fields.map{$0.validator.isValid}.reduceAnd()
    }
    
    func firstInvalidField() -> Field? {
        return fields.filter{$0.validator.isValid == false }.first
    }
    
    func field(_ type: FieldType) -> Field? {
        return fields.filter{$0.fieldType == type }.first
    }
}
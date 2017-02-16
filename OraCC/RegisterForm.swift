import Foundation

struct RegisterForm {
    var fields: [Field]
    
    init(){
        fields = [Field(label: "Name", placeholder: "Your Name", fieldType: .text, validator: TextValidator()),
                Field(label: "Email", placeholder: "Your Email", fieldType: .email, validator: EmailValidator()),
                  Field(label: "Password", placeholder: "Your Password", fieldType: .password,validator: PasswordValidator()),
                        Field(label: "Confirm", placeholder: "Password Confirm", fieldType: .passwordConfirm,validator: PasswordValidator())
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

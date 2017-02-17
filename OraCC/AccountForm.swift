import Foundation

struct AccountForm: FormRepresentable {
    var fields: [Field]
    
    init(){
        fields = [Field(label: "Name", placeholder: "Your Name", fieldType: .name, validator: TextValidator()),
                  Field(label: "Email", placeholder: "Your Email", fieldType: .email, validator: EmailValidator()),
                  Field(label: "Password", placeholder: "Your Password", fieldType: .password,validator: PasswordValidator()),
                  Field(label: "Confirm", placeholder: "Password Confirm", fieldType: .passwordConfirm,validator: PasswordValidator())
        ]
    }
}

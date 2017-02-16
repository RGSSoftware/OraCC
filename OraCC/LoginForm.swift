import Foundation

struct LoginForm: FormRepresentable {
    var fields: [Field]
    
    init(){
        fields = [Field(label: "Email", placeholder: "Your Email", fieldType: .email, validator: EmailValidator()),
                  Field(label: "Password", placeholder: "Your Password", fieldType: .password,validator: PasswordValidator())
        ]
    }
}

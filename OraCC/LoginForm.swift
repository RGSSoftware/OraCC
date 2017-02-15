import Foundation

struct LoginForm {
    lazy var fields: [Field] = {
        return [Field(label: "Email", placeholder: "Your Email", validator: EmailValidator()),
                Field(label: "Password", placeholder: "Your Password", validator: PasswordValidator())
        ]
    }()
}

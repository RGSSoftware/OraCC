 import Foundation
 
 protocol Validator {
    var isValid: Bool { get }
    var validator: (_ value: String?) -> (Bool) { get set }
    
    var value: String? { get set }
    
    var errorMessage: String { get }
 }

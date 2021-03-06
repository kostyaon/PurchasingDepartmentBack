import Vapor
import Fluent

final class User: Model, Content {
    
    static let schema = "users"
    
    @ID(custom: "id")
    var id: Int?
    
    @Field(key: "login")
    var login: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "surname")
    var surname: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "phone")
    var phone: String
    
    @Field(key: "role")
    var role: Bool
    
    init() { }
    
    init(id: Int? = nil, login: String, password: String, name: String, surname: String, phone: String, email: String, role: Bool) {
        self.id = id
        self.login = login
        self.password = password
        self.name = name
        self.phone = phone
        self.surname = surname
        self.email = email
        self.role = role
    }
}


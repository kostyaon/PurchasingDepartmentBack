import Vapor
import Fluent

final class User: Model, Content {
    
    static let schema = "users"
    
    @ID(key: .id)
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
    
    @Field(key: "role")
    var role: Bool
    
    init() { }
    
    init(id: Int? = nil, login: String, password: String, name: String, surname: String, email: String, role: Bool) {
        self.id = id
        self.login = login
        self.password = password
        self.name = name
        self.surname = surname
        self.email = email
        self.role = role
    }
}


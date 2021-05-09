import Vapor
import Fluent

final class Supplier: Model, Content {
    
    static let schema = "suppliers"
    
    @ID(custom: "supplier_id")
    var id: Int?

    @Field(key: "name")
    var name: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "address")
    var address: String
    
    @Field(key: "phone")
    var phone: String
    
    init() { }
    
    init(id: Int? = nil, name: String, email: String, address: String, phone: String) {
        self.id = id
        self.name = name
        self.email = email
        self.address = address
        self.phone = phone
    }
}


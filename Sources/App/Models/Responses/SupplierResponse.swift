import Vapor

struct SupplierResponse: Content {
    
    var name: String
    var email: String
    var address: String
    var phone: String
    var products: [ProductCatalog]
}

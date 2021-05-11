import Vapor

struct SupplierResponse: Content {
    
    var id: Int
    var name: String
    var email: String
    var address: String
    var phone: String
    var products: [SupplierCatalog]
    
    init() {
        id = 0
        name = ""
        email = ""
        address = ""
        phone = ""
        products = []
    }
}

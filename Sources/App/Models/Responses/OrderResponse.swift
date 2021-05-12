import Vapor

struct OrderResponse: Content {
    // Product fields
    var name: String
    var partNumber: String

    var orderId: Int?
    var numberOfItems: Int
    var note: String?
    var date: String?
    var status: String
    var selectedPrice: Double?
    var requestNumber: Int
    var suppliers: [Supplier]
    var selectedSupplierId: Supplier.IDValue?
    
    init() {
        self.name = ""
        self.partNumber = ""
        self.numberOfItems = 0
        self.status = ""
        self.requestNumber = 0
        self.suppliers = []
    }
}

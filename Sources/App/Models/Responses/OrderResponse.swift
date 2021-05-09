import Vapor

struct OrderResponse: Content {
    // Product fields
    var name: String
    var partNumber: String

    var orderId: Int
    var numberOfItems: Int
    var note: String?
    var date: String
    var status: String
    var totalPrice: Double
    var suppliers: [Supplier]
    var selectedSupplier: Supplier.IDValue?
}

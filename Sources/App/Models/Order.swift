import Vapor
import Fluent

final class Order: Model, Content {
    
    static let schema = "order"
    
    @ID(custom: "order_id")
    var id: Int?

    @Field(key: "product_id")
    var productId: ProductCatalog.IDValue
    
    @Field(key: "request_number")
    var requestNumber: Int
    
    @Field(key: "date")
    var date: String?
    
    @Field(key: "status")
    var status: String
    
    @Field(key: "total_price")
    var totalPrice: Double?
    
    @Field(key: "note")
    var note: String?
    
    init() { }
    
    init(id: Int? = nil, productId: ProductCatalog.IDValue, requestNumber: Int, date: String? = nil, status: String, totalPrice: Double? = nil, note: String? = nil) {
        self.id = id
        self.productId = productId
        self.requestNumber = requestNumber
        self.date = date
        self.status = status
        self.totalPrice = totalPrice
        self.note = note
    }
}


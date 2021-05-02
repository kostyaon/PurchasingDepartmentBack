import Vapor
import Fluent

final class OrderSupplier: Model, Content {
    
    static let schema = "order_supplier"
    
    @ID(custom: "id")
    var id: Int?
    
    @Field(key: "order_id")
    var orderId: Order.IDValue
    
    @Field(key: "supplier_id")
    var supplierId: Supplier.IDValue
    
    init() { }
    
    init(id: Int? = nil, orderId: Order.IDValue, supplierId: Supplier.IDValue) {
        self.id = id
        self.orderId = orderId
        self.supplierId = supplierId
    }
}

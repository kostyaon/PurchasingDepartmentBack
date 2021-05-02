import Vapor
import Fluent

final class SupplierSupplierCatalog: Model, Content {
    
    static let schema = "supplier_supplier_catalog"
    
    @ID(custom: "id")
    var id: Int?
    
    @Field(key: "catalog_id")
    var catalogId: SupplierCatalog.IDValue
    
    @Field(key: "supplier_id")
    var supplierId: Supplier.IDValue
    
    init() { }
    
    init(id: Int? = nil, catalogId: SupplierCatalog.IDValue, supplierId: Supplier.IDValue) {
        self.id = id
        self.catalogId = catalogId
        self.supplierId = supplierId
    }
}

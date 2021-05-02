import Fluent

struct CreateSupplierSupplierCatalog: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("supplier_supplier_catalog")
            .field("id", .int, .identifier(auto: true))
            .field("catalog_id", .int)
            .field("supplier_id", .int)
            .foreignKey("catalog_id", references: "supplier_catalog", "catalog_id", onDelete: .cascade, onUpdate: .cascade)
            .foreignKey("supplier_id", references: "suppliers", "supplier_id", onDelete: .cascade, onUpdate: .cascade)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("supplier_supplier_catalog").delete()
    }
}

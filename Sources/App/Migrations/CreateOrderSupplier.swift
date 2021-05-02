import Fluent

struct CreateOrderSupplier: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("order_supplier")
            .field("id", .int, .identifier(auto: true))
            .field("order_id", .int)
            .field("supplier_id", .int)
            .foreignKey("order_id", references: "order", "order_id", onDelete: .cascade)
            .foreignKey("supplier_id", references: "suppliers", "supplier_id", onDelete: .cascade, onUpdate: .cascade)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("order_supplier").delete()
    }
}

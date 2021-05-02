import Fluent

struct CreateOrder: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("order")
            .field("order_id", .int, .identifier(auto: true))
            .field("product_id", .int)
            .field("request_number", .int)
            .field("date", .string)
            .field("status", .string)
            .field("total_price", .double)
            .field("measurement_unit", .string)
            .field("note", .string)
            .foreignKey("product_id", references: "product_catalog", "product_id", onDelete: .cascade, onUpdate: .cascade)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("order").delete()
    }
}


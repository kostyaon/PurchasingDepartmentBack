import Fluent

struct CreateSupplier: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("suppliers")
            .field("supplier_id", .int, .identifier(auto: true))
            .field("name", .string)
            .field("email", .string)
            .field("address", .string)
            .field("phone", .string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("suppliers").delete()
    }
}


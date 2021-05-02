import Fluent

struct CreateProductCatalog: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("product_catalog")
            .field("product_id", .int, .identifier(auto: true))
            .field("name", .string)
            .field("part_number", .string)
            .field("measurement_unit", .string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("product_catalog").delete()
    }
}

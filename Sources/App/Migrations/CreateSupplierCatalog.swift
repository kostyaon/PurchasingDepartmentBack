import Fluent

struct CreateSupplierCatalog: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("supplier_catalog")
            .field("catalog_id", .int, .identifier(auto: true))
            .field("name", .string)
            .field("part_number", .string)
            .field("measurement_unit", .string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("supplier_catalog").delete()
    }
}

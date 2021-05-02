import Fluent

struct CreateUser: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users")
            .id()
            .field("login", .string)
            .field("password", .string)
            .field("name", .string)
            .field("surname", .string)
            .field("email", .string)
            .field("role", .bool)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}


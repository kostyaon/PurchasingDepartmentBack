import Fluent

struct CreateUser: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users")
            .field("id", .int, .identifier(auto: true))
            .field("login", .string)
            .field("password", .string)
            .field("name", .string)
            .field("surname", .string)
            .field("email", .string)
            .field("phone", .string)
            .field("role", .bool)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}


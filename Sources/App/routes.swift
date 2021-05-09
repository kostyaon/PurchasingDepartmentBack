import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: AllOrdersController())
    try app.register(collection: UserController())
    try app.register(collection: ProductController())
    try app.register(collection: OrderController())
    try app.register(collection: SupplierController())
    try app.register(collection: CatalogController())
    
    // Auth: GET, POST
    app.post("login") { req -> EventLoopFuture<User> in
        let loginData = try req.content.decode(LoginData.self)
        return User.query(on: req.db)
            .filter(\.$login == loginData.login)
            .filter(\.$password == loginData.password)
            .first()
            .unwrap(or: Abort(.notFound))
    }
    
    app.post("register") { req -> EventLoopFuture<User> in
        let user = try req.content.decode(User.self)
        return user.create(on: req.db).map { user }
    }
    
    // OrderSuppliers: GET, POST
    app.get("order-suppliers") { req in
        OrderSupplier.query(on: req.db).all()
    }
    
    app.post("order-suppliers") { req -> EventLoopFuture<OrderSupplier> in
        let orderSupplier = try req.content.decode(OrderSupplier.self)
        return orderSupplier.create(on: req.db)
            .map { orderSupplier }
    }
    
    // SupplierSupplierCatalog: GET, POST
    app.get("supplier-sup-catalog") { req in
        SupplierSupplierCatalog.query(on: req.db).all()
    }
    
    app.post("supplier-sup-catalog") { req -> EventLoopFuture<SupplierSupplierCatalog> in
        let supplierSupCatalog = try req.content.decode(SupplierSupplierCatalog.self)
        return supplierSupCatalog.create(on: req.db)
            .map { supplierSupCatalog }
    }
}

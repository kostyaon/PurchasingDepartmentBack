import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
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
    

    
    
    
    
    
    
    
    
    
    // Users: GET, POST
    app.get("users") { req in
        User.query(on: req.db).all()
    }
    
    app.post("users") { req -> EventLoopFuture<User> in
        let user = try req.content.decode(User.self)
        return user.create(on: req.db)
            .map { user }
    }
    
    // ProductCatalog: GET, POST
    app.get("products") { req in
        ProductCatalog.query(on: req.db).all()
    }
    
    app.post("products") { req -> EventLoopFuture<ProductCatalog> in
        let catalog = try req.content.decode(ProductCatalog.self)
        return catalog.create(on: req.db)
            .map { catalog }
    }

    // Orders: GET, POST
    app.get("orders") { req in
        Order.query(on: req.db).all()
    }
    
    app.post("orders") { req -> EventLoopFuture<Order> in
        let order = try req.content.decode(Order.self)
        return order.create(on: req.db)
            .map { order }
    }
    
    // Suppliers: GET, POST
    app.get("suppliers") { req in
        Supplier.query(on: req.db).all()
    }
    
    app.post("suppliers") { req -> EventLoopFuture<Supplier> in
        let supplier = try req.content.decode(Supplier.self)
        return supplier.create(on: req.db)
            .map { supplier }
    }
    
    // SupplierCatalog: GET, POST
    app.get("catalogs") { req in
        SupplierCatalog.query(on: req.db).all()
    }
    
    app.post("catalogs") { req -> EventLoopFuture<SupplierCatalog> in
        let supplierCatalog = try req.content.decode(SupplierCatalog.self)
        return supplierCatalog.create(on: req.db)
            .map { supplierCatalog }
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

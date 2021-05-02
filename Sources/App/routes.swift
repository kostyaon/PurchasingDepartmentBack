import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
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
    
    // Catalogs: GET, POST
    app.get("catalogs") { req in
        ProductCatalog.query(on: req.db).all()
    }
    
    app.post("catalogs") { req -> EventLoopFuture<ProductCatalog> in
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
}

import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("users") { req in
        User.query(on: req.db).all()
    }
    
    app.post("users") { req -> EventLoopFuture<User> in
        let user = try req.content.decode(User.self)
        return user.create(on: req.db)
            .map { user }
    }
    
    app.get("catalogs") { req in
        ProductCatalog.query(on: req.db).all()
    }
    
    app.post("catalogs") { req -> EventLoopFuture<ProductCatalog> in
        let catalog = try req.content.decode(ProductCatalog.self)
        return catalog.create(on: req.db)
            .map { catalog }
    }

}

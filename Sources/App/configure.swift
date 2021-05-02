import Fluent
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    // Configure migrations
    app.migrations.add(CreateUser())
    app.migrations.add(CreateProductCatalog())
    app.migrations.add(CreateOrder())
    app.migrations.add(CreateSupplier())
    app.migrations.add(CreateSupplierCatalog())
    app.migrations.add(CreateOrderSupplier())
    app.migrations.add(CreateSupplierSupplierCatalog())

    // register routes
    try routes(app)
}

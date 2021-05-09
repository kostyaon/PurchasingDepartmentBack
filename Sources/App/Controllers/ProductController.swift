import Vapor
import Fluent

final class ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: getProducts)
        products.post(use: postProduct)
    }
    
    func getProducts(req: Request) throws -> EventLoopFuture<[ProductCatalog]> {
        return ProductCatalog.query(on: req.db).all()
    }
    
    func postProduct(req: Request) throws -> EventLoopFuture<ProductCatalog> {
        let catalog = try req.content.decode(ProductCatalog.self)
        return catalog.create(on: req.db)
            .map { catalog }
    }
}

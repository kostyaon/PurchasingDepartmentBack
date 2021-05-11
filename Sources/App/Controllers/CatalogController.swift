import Vapor
import Fluent

final class CatalogController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let catalogs = routes.grouped("catalogs")
        catalogs.get(use: getCatalogs)
        catalogs.post(use: postCatalog)
    }
    
    func getCatalogs(req: Request) throws -> EventLoopFuture<[SupplierCatalog]> {
        return SupplierCatalog.query(on: req.db).all()
    }
    
    func postCatalog(req: Request) throws -> EventLoopFuture<SupplierCatalog> {
        let supplierCatalog = try req.content.decode(SupplierCatalog.self)
        return supplierCatalog.create(on: req.db)
            .map { supplierCatalog }
    }
}

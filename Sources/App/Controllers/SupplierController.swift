import Vapor
import Fluent

final class SupplierController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let suppliers = routes.grouped("suppliers")
        //suppliers.get(use: getSuppliers)
        suppliers.post(use: postSupplier)
    }
    
//    func getSuppliers(req: Request) throws -> EventLoopFuture<[SupplierResponse]> {
//        return Supplier.query(on: req.db)
//            .join(SupplierSupplierCatalog.self, on: \Supplier.$id == \SupplierSupplierCatalog.$supplierId, method: .inner)
//            .join(SupplierCatalog.self, on: \SupplierCatalog.$id == )
//            .all()
//            .map { suppliers in
//                for supplier
//                SupplierResponse(supp )
//            }
//    }
    
    func postSupplier(req: Request) throws -> EventLoopFuture<Supplier> {
        let supplier = try req.content.decode(Supplier.self)
        return supplier.create(on: req.db)
            .map { supplier }
    }
}

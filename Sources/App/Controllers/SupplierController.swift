import Vapor
import Fluent

final class SupplierController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let suppliers = routes.grouped("suppliers")
        suppliers.get(use: getSuppliers)
        suppliers.post(use: postSupplier)
    }
    
    func getSuppliers(req: Request) throws -> EventLoopFuture<[SupplierResponse]> {
        var response: [SupplierResponse] = []
        
        return Supplier.query(on: req.db)
            .join(SupplierSupplierCatalog.self, on: \Supplier.$id == \SupplierSupplierCatalog.$supplierId, method: .inner)
            .join(SupplierCatalog.self, on: \SupplierCatalog.$id == \SupplierSupplierCatalog.$catalogId, method: .inner)
            .all()
            .map { suppliers in
                print(suppliers)
                for supplier in suppliers {
                    print(supplier)
                    var supplierResponse = SupplierResponse()
                    
                    supplierResponse.id = supplier.id ?? 0
                    supplierResponse.name = supplier.name
                    supplierResponse.email = supplier.email
                    supplierResponse.address = supplier.address
                    supplierResponse.phone = supplier.phone
                    
                    let product = try! supplier.joined(SupplierCatalog.self)
                    let newProduct = SupplierCatalog()
                    newProduct.id = product.id
                    newProduct.name = product.name
                    newProduct.partNumber = product.partNumber
                    newProduct.measurementUnit = product.measurementUnit
                    supplierResponse.products.append(newProduct)
                    
                    for (index, res) in response.enumerated() {
                        if res.id == supplier.id {
                            let prod = res.products
                            supplierResponse.products.append(contentsOf: prod)
                            response.remove(at: index)
                        }
                    }
                    
                    response.append(supplierResponse)
                }
                return response
            }
    }
    
    func postSupplier(req: Request) throws -> EventLoopFuture<Supplier> {
        let supplier = try req.content.decode(Supplier.self)
        return supplier.create(on: req.db)
            .map { supplier }
    }
}

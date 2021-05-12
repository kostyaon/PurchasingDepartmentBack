import Vapor
import Fluent

final class SupplierController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let supplier = routes.grouped("supplier")
        supplier.get(use: getSuppliers)
    }
    
    func getSuppliers(req: Request) throws -> EventLoopFuture<SupplierResponse> {
        let supId = try! req.query.decode(SupplierID.self)
        var response: [SupplierResponse] = []
        
        return Supplier.query(on: req.db)
            .join(SupplierSupplierCatalog.self, on: \Supplier.$id == \SupplierSupplierCatalog.$supplierId, method: .inner)
            .join(SupplierCatalog.self, on: \SupplierCatalog.$id == \SupplierSupplierCatalog.$catalogId, method: .inner)
            .all()
            .map { suppliers in
                print(suppliers)
                for supplier in suppliers {
                    print(supplier)
                    if supplier.id ?? 0 == supId.id {
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
                }
                return response.first!
            }
    }
}

import Vapor
import Fluent

final class AllOrdersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let orders = routes.grouped("allOrders")
        orders.get(use: joined)
    }
    
    func joined(req: Request) throws -> EventLoopFuture<[OrderResponse]> {
        var response: [OrderResponse] = []
        
        
        return Order.query(on: req.db)
            .filter(\.$status == "requested")
            .join(ProductCatalog.self, on: \Order.$productId == \ProductCatalog.$id, method: .inner)
            .all()
            .map { orders in
                for order in orders {
                    // Add order info to the response
                    var orderResponse = OrderResponse()
                    let product = try! order.joined(ProductCatalog.self)
                    orderResponse.name = product.name
                    orderResponse.partNumber = product.partNumber
                    orderResponse.orderId = order.id
                    orderResponse.numberOfItems = order.numberOfItems
                    orderResponse.note = order.note
                    orderResponse.date = order.date
                    orderResponse.status = order.status
                    orderResponse.totalPrice = order.totalPrice
                    orderResponse.selectedSupplierId = order.selectedSupplierId
                    
                    /* ProductCatalog.query(on: req.db)
                     .join(SupplierCatalog.self, on: \SupplierCatalog.$partNumber == \ProductCatalog.$partNumber, method: .inner)
                     .filter(\.$id == order.productId)
                     .first()
                     .unwrap(or: Abort(.noContent))
                     .map { prod  in
                     print("1")
                     let catalogProduct = try! prod.joined(ProductCatalog.self)
                     SupplierSupplierCatalog.query(on: req.db)
                     .join(SupplierCatalog.self, on: \SupplierCatalog.$id == \SupplierSupplierCatalog.$catalogId, method: .inner)
                     .filter(\SupplierSupplierCatalog.$catalogId == catalogProduct.id ?? 0)
                     .all()
                     .map {
                     for sup in $0 {
                     Supplier.query(on: req.db)
                     .filter(\.$id == sup.supplierId)
                     .first()
                     .unwrap(or: Abort(.noContent))
                     .map { supplier in
                     print(supplier)
                     orderResponse.suppliers.append(supplier)
                     }
                     }
                     }
                     
                     }
                     let prodCatalog = SupplierCatalog.query(on: req.db)
                     .join(ProductCatalog.self, on: \SupplierCatalog.$partNumber == \ProductCatalog.$partNumber, method: .inner)
                     .filter(ProductCatalog.self, \.$id == order.productId)
                     .join(SupplierSupplierCatalog.self, on: \SupplierSupplierCatalog.$catalogId == \SupplierCatalog.$id)
                     .join(Supplier.self, on: \Supplier.$id == \SupplierSupplierCatalog.$supplierId)
                     .all()
                     .map {
                     print($0)
                     for sup in $0 {
                     let supplier = try! sup.joined(Supplier.self)
                     let newSupplier = Supplier()
                     newSupplier.id = supplier.id
                     newSupplier.name = supplier.name
                     newSupplier.email = supplier.email
                     newSupplier.address = supplier.address
                     newSupplier.phone = supplier.phone
                     print(newSupplier)
                     orderResponse.suppliers.append(newSupplier)
                     }
                     }*/
                    orderResponse.suppliers = self.getSuppliers(req: req, productId: order.productId)
                    
                    
                    response.append(orderResponse)
                }
                return response
            }
    }
    
    func getSuppliers(req: Request, productId: Int) -> [Supplier] {
        var suppliers: [Supplier] = []
        SupplierCatalog.query(on: req.db)
            .join(ProductCatalog.self, on: \SupplierCatalog.$partNumber == \ProductCatalog.$partNumber, method: .inner)
            .filter(ProductCatalog.self, \.$id == productId)
            .join(SupplierSupplierCatalog.self, on: \SupplierSupplierCatalog.$catalogId == \SupplierCatalog.$id)
            .join(Supplier.self, on: \Supplier.$id == \SupplierSupplierCatalog.$supplierId)
            .all()
            .map {
                for sup in $0 {
                    let supplier = try! sup.joined(Supplier.self)
                    let newSupplier = Supplier()
                    newSupplier.id = supplier.id
                    newSupplier.name = supplier.name
                    newSupplier.email = supplier.email
                    newSupplier.address = supplier.address
                    newSupplier.phone = supplier.phone
                    print(newSupplier)
                    suppliers.append(newSupplier)
                }
            }
        return suppliers
    }
}

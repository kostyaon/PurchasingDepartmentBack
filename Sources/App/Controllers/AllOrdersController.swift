import Vapor
import FluentSQL
import FluentSQLiteDriver
import Fluent

final class AllOrdersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let orders = routes.grouped("allOrders")
        orders.get(use: joined)
    }
    
    func joined(req: Request) throws -> EventLoopFuture<[OrderResponse]> {
        var response: [OrderResponse] = []
        var suppliers: [Supplier] = []
        
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
                    
                   ProductCatalog.query(on: req.db)
                        .join(SupplierCatalog.self, on: \SupplierCatalog.$partNumber == \ProductCatalog.$partNumber, method: .inner)
                        .filter(\.$id == order.productId)
                        .first()
                        .unwrap(or: Abort(.noContent))
                        .map { prod in
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
                    
                    response.append(orderResponse)
                }
                return response
            }
    }
    
    
 /*   // Get products from SupplierCatalog and ProductCatalog, who have identical partNumber
    func getSupplier(req: Request, productId: Int) throws -> EventLoopFuture<[Supplier]> {
        return SupplierCatalog.query(on: req.db)
            .join(ProductCatalog.self, on: \SupplierCatalog.$partNumber == \ProductCatalog.$partNumber, method: .inner)
            .filter(\.$id == productId)
            .first()
            .map { prod in
                Supplier.query(on: req.db)
                    .join(SupplierSupplierCatalog.self, on: \Supplier.$id == \SupplierSupplierCatalog.$supplierId, method: .inner)
                    .all()
                    .map {
                        for sup in $0 {
                            suppliers.append(sup)
                        }
                    }
            }
    }
    
    // Get suppliers, who have our products
    func getSuppliers(req: Request) throws -> EventLoopFuture<[Supplier]> {
        var response: [Supplier] = []
        
        let products = try getProducts(req: req)
            .wait()
        
        let suppliers = try Supplier.query(on: req.db)
            .join(SupplierSupplierCatalog.self, on: \Supplier.$id == \SupplierSupplierCatalog.$supplierId)
            .all()
            .wait()
        
        for supplier in suppliers {
            for product in products {
                Supplier.query(on: req.db)
                    .filter(supplier.id = product.id)
                    .first()
                    .flatMap {
                        response.append(<#T##newElement: Supplier##Supplier#>)
                    }
            }
        }
        
        return response
    }*/
}

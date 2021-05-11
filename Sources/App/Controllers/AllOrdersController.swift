import Vapor
import Fluent

final class AllOrdersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let orders = routes.grouped("allOrders")
        orders.get(use: joined)
        orders.post(use: updateOrder)
    }
    
    func joined(req: Request) throws -> EventLoopFuture<[OrderResponse]> {
        let status = try! req.query.decode(Status.self)
        var response: [OrderResponse] = []
        
        return Order.query(on: req.db)
            .filter(\.$status == status.status ?? "")
            .join(ProductCatalog.self, on: \Order.$productId == \ProductCatalog.$id, method: .inner)
            .join(SupplierCatalog.self, on: \SupplierCatalog.$partNumber == \ProductCatalog.$partNumber, method: .inner)
            .join(SupplierSupplierCatalog.self, on: \SupplierSupplierCatalog.$catalogId == \SupplierCatalog.$id)
            .join(Supplier.self, on: \Supplier.$id == \SupplierSupplierCatalog.$supplierId)
            .all()
            .map { orders in
                for order in orders {
                    print(order)
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
                    
                    let supplier = try! order.joined(Supplier.self)
                    let newSupplier = Supplier()
                    newSupplier.id = supplier.id
                    newSupplier.name = supplier.name
                    newSupplier.email = supplier.email
                    newSupplier.address = supplier.address
                    newSupplier.phone = supplier.phone
                    orderResponse.suppliers.append(newSupplier)
                    
                    for (index, res) in response.enumerated() {
                        if res.orderId == order.id {
                            let sups = res.suppliers
                            orderResponse.suppliers.append(contentsOf: sups)
                            response.remove(at: index)
                        }
                    }
                    
                    response.append(orderResponse)
                }
                return response
            }
    }
    
    func updateOrder(req: Request) throws -> EventLoopFuture<Order> {
        let response = try req.content.decode(OrderResponse.self)
        let suppliers = response.suppliers
        for supplier in suppliers {
            OrderSupplier(orderId: response.orderId ?? 0, supplierId: supplier.id ?? 0).create(on: req.db)
        }
        
        Order.query(on: req.db)
            .set(\.$date, to: response.date)
            .set(\.$note, to: response.note)
            .set(\.$status, to: response.status)
            .filter(\.$id == response.orderId ?? 0)
            .update()
        
        return Order.query(on: req.db)
            .filter(\.$id == response.orderId ?? 0)
            .first()
            .unwrap(or: Abort(.noContent))
    }
}

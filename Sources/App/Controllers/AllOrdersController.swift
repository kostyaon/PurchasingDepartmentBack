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
                    var orderResponse = OrderResponse()
                    let product = try! order.joined(ProductCatalog.self)
                    orderResponse.name = product.name
                    orderResponse.partNumber = product.partNumber
                    orderResponse.orderId = order.id
                    orderResponse.numberOfItems = order.numberOfItems
                    orderResponse.note = order.note
                    orderResponse.date = order.date
                    orderResponse.totalPrice = order.totalPrice
                    orderResponse.suppliers = []
                    orderResponse.selectedSupplierId = order.selectedSupplierId
                    response.append(orderResponse)
                }
                return response
            }
    }
}

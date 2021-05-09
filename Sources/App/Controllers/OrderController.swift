import Vapor
import Fluent

final class OrderController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let orders = routes.grouped("orders")
        orders.get(use: getOrders)
        orders.post(use: postOrder)
    }
    
    func getOrders(req: Request) throws -> EventLoopFuture<[Order]> {
        return Order.query(on: req.db).all()
    }
    
    func postOrder(req: Request) throws -> EventLoopFuture<Order> {
        let order = try req.content.decode(Order.self)
        return order.create(on: req.db)
            .map { order }
    }
}

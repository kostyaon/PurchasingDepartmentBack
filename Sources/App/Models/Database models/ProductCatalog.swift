import Vapor
import Fluent

final class ProductCatalog: Model, Content {
 
    static let schema = "product_catalog"
    
    @ID(custom: "product_id")
    var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "part_number")
    var partNumber: String
    
    @Field(key: "measurement_unit")
    var measurementUnit: String
    
    init() { }
    
    init(id: Int? = nil, name: String, partNumber: String, measurementUnit: String) {
        self.id = id
        self.name = name
        self.partNumber = partNumber
        self.measurementUnit = measurementUnit
    }
}

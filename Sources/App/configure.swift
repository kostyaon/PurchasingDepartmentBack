import Fluent
import FluentSQLiteDriver
import Vapor

public func configure(_ app: Application) throws {
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    // Configure migrations
    app.migrations.add(CreateUser())
    app.migrations.add(CreateProductCatalog())
    app.migrations.add(CreateOrder())
    app.migrations.add(CreateSupplier())
    app.migrations.add(CreateSupplierCatalog())
    app.migrations.add(CreateOrderSupplier())
    app.migrations.add(CreateSupplierSupplierCatalog())
    try app.autoMigrate().wait()
    
    // Describe data
    let users = [
        User(login: "purchase04", password: "mEfAgOt", name: "Martin", surname: "Belov", email: "belov.ukraine@purchase.me", role: true),
        User(login: "purchase03", password: "penisInMouthPlease", name: "Evgeniy", surname: "Revyako", email: "revyako.bear@purchase.me", role: false),
        User(login: "purchase02", password: "BitchImGay", name: "Artyom", surname: "Batura", email: "batura.eren.yeager@purchase.me", role: true),
        User(login: "purchase01", password: "curlyGuy", name: "Artyom", surname: "Ystinov", email: "ystinov.music@purchase.me", role: false),
        User(login: "purchase00", password: "GorodSochi", name: "Konstantin", surname: "Petrikevich", email: "aVperediEsche3dnya.i3nochi@purchase.me", role: true),
        User(login: "admin", password: "administrator", name: "Big", surname: "Head", email: "department.head@purchase.me", role: true)
    ]
    
    let products = [
        ProductCatalog(name: "Low pen form", partNumber: "0000low", measurementUnit: "piece"),
        ProductCatalog(name: "Standart pen form", partNumber: "0001st", measurementUnit: "piece"),
        ProductCatalog(name: "High pen form", partNumber: "0002high", measurementUnit: "piece"),
        ProductCatalog(name: "Kernel L", partNumber: "0000kerl", measurementUnit: "piece"),
        ProductCatalog(name: "Kernel M", partNumber: "0001kerm", measurementUnit: "piece"),
        ProductCatalog(name: "Big pencil form", partNumber: "0000bigpenc", measurementUnit: "piece"),
        ProductCatalog(name: "Small pencil form", partNumber: "0001smallpenc", measurementUnit: "piece"),
        ProductCatalog(name: "Paint white", partNumber: "0000paintwhite", measurementUnit: "piece"),
        ProductCatalog(name: "Paint red", partNumber: "0001paintred", measurementUnit: "piece"),
        ProductCatalog(name: "Paint black", partNumber: "0000paintblack", measurementUnit: "piece")
    ]
    
    let supplierProducts = [
        SupplierCatalog(name: "Low pen form", partNumber: "0000low", measurementUnit: "piece"),
        SupplierCatalog(name: "Standart pen form", partNumber: "0001st", measurementUnit: "piece"),
        SupplierCatalog(name: "High pen form", partNumber: "0002high", measurementUnit: "piece"),
        SupplierCatalog(name: "Kernel L", partNumber: "0000kerl", measurementUnit: "piece"),
        SupplierCatalog(name: "Kernel M", partNumber: "0001kerm", measurementUnit: "piece"),
        SupplierCatalog(name: "Big pencil form", partNumber: "0000bigpenc", measurementUnit: "piece"),
        SupplierCatalog(name: "Small pencil form", partNumber: "0001smallpenc", measurementUnit: "piece"),
        SupplierCatalog(name: "Paint white", partNumber: "0000paintwhite", measurementUnit: "piece"),
        SupplierCatalog(name: "Paint red", partNumber: "0001paintred", measurementUnit: "piece"),
        SupplierCatalog(name: "Paint black", partNumber: "0000paintblack", measurementUnit: "piece")
    ]
   
    let suppliers = [
        Supplier(name: "PoraPrisnatChtoYaNeEdick", email: "egor.cringe@music.com", address: "USA, NJ, Camden, 3266 American Drive", phone: "609-876-7901"),
        Supplier(name: "SomeBodyOnceToldMe", email: "shrek@sax.com", address: "USA, CA, SAN JOSE, 1607 Kinney Street", phone: "408-305-1411"),
        Supplier(name: "PredlagaetNalSdatayaElka", email: "satyr@cool.com", address: "USA, TN, Santa Fe, 1900 Glory Road", phone: "615-660-0175"),
        Supplier(name: "NastolkoNaturalChtoNikogdaNeMacalPerchik", email: "perchik@natural.com", address: "USA, TX, SUMNER, 3565 Hillcrest Drive", phone: "432-301-2629"),
        Supplier(name: "VoMneDyrkiOtPulNoYaNeDyraviy", email: "dyrka@ochok.com", address: "USA, CA, Gardena, 3401 Reynolds Alley", phone: "562-260-1517")
    ]
    
    let orders = [
        Order(productId: 1, requestNumber: 100, date: "01.01.2021", status: "requested", numberOfItems: 10),
        Order(productId: 2, requestNumber: 101, date: "02.02.2021", status: "awaitingForPrice", note: "Call to Elon Musk", numberOfItems: 20),
        Order(productId: 3, requestNumber: 102, date: "03.03.2021", status: "inProgress", totalPrice: 333.3, note: "This is for Rick C-137", numberOfItems: 30, selectedSupplierId: 1),
        Order(productId: 4, requestNumber: 103, date: "04.04.2021", status: "dispute", totalPrice: 444.4, numberOfItems: 40, selectedSupplierId: 2),
        Order(productId: 5, requestNumber: 104, date: "05.05.2021", status: "completed", totalPrice: 555.5, numberOfItems: 50),
        Order(productId: 6, requestNumber: 105, date: "06.06.2021", status: "requested", note: "Morty, what a F*** are you doing here?", numberOfItems: 60),
        Order(productId: 7, requestNumber: 106, date: "07.07.2021", status: "awaitingForPrice", note: "Rick, we need Meeseeks!", numberOfItems: 70, selectedSupplierId: 3),
        Order(productId: 8, requestNumber: 107, date: "08.08.2021", status: "inProgress", totalPrice: 888.8, numberOfItems: 80, selectedSupplierId: 4),
        Order(productId: 9, requestNumber: 108, date: "09.09.2021", status: "dispute", totalPrice: 999.9, numberOfItems: 90, selectedSupplierId: 1),
        Order(productId: 10, requestNumber: 109, date: "10.10.2021", status: "completed", totalPrice: 1000.0, numberOfItems: 100, selectedSupplierId: 2)
    ]
    
    let ordersSupplier = [
        OrderSupplier(orderId: 1, supplierId: 1),
        OrderSupplier(orderId: 1, supplierId: 2),
        OrderSupplier(orderId: 1, supplierId: 3),
        OrderSupplier(orderId: 1, supplierId: 4),
        OrderSupplier(orderId: 2, supplierId: 1),
        OrderSupplier(orderId: 2, supplierId: 2),
        OrderSupplier(orderId: 3, supplierId: 3),
        OrderSupplier(orderId: 4, supplierId: 4),
        OrderSupplier(orderId: 5, supplierId: 1),
        OrderSupplier(orderId: 5, supplierId: 2),
        OrderSupplier(orderId: 5, supplierId: 3),
        OrderSupplier(orderId: 6, supplierId: 4),
        OrderSupplier(orderId: 7, supplierId: 4),
        OrderSupplier(orderId: 8, supplierId: 4),
        OrderSupplier(orderId: 9, supplierId: 2),
        OrderSupplier(orderId: 9, supplierId: 3),
        OrderSupplier(orderId: 10, supplierId: 1),
        OrderSupplier(orderId: 10, supplierId: 4)
    ]
    
    let suppliersCatalog = [
        SupplierSupplierCatalog(catalogId: 1, supplierId: 1),
        SupplierSupplierCatalog(catalogId: 2, supplierId: 1),
        SupplierSupplierCatalog(catalogId: 3, supplierId: 1),
        SupplierSupplierCatalog(catalogId: 4, supplierId: 1),
        SupplierSupplierCatalog(catalogId: 5, supplierId: 1),
        SupplierSupplierCatalog(catalogId: 6, supplierId: 2),
        SupplierSupplierCatalog(catalogId: 7, supplierId: 2),
        SupplierSupplierCatalog(catalogId: 8, supplierId: 2),
        SupplierSupplierCatalog(catalogId: 9, supplierId: 2),
        SupplierSupplierCatalog(catalogId: 10, supplierId: 2),
        SupplierSupplierCatalog(catalogId: 10, supplierId: 3),
        SupplierSupplierCatalog(catalogId: 9, supplierId: 3),
        SupplierSupplierCatalog(catalogId: 8, supplierId: 3),
        SupplierSupplierCatalog(catalogId: 7, supplierId: 3),
        SupplierSupplierCatalog(catalogId: 6, supplierId: 3),
        SupplierSupplierCatalog(catalogId: 5, supplierId: 4),
        SupplierSupplierCatalog(catalogId: 4, supplierId: 4),
        SupplierSupplierCatalog(catalogId: 3, supplierId: 4),
        SupplierSupplierCatalog(catalogId: 2, supplierId: 4),
        SupplierSupplierCatalog(catalogId: 1, supplierId: 4)
    ]
    
    // Fill tables with describing data
    // Uncomment for filling tables (then you can delete it or comment back)
//    users.create(on: app.db)
//    products.create(on: app.db)
//    supplierProducts.create(on: app.db)
//    suppliers.create(on: app.db)
//    orders.create(on: app.db)
//    ordersSupplier.create(on: app.db)
//    suppliersCatalog.create(on: app.db)
    
    // register routes
    try routes(app)
}

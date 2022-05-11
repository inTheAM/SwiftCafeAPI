import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    let databaseName: String
    let databasePort: Int
    
    switch app.environment {
        case .testing:
            databaseName = "swiftcafe-test"
            if let testPort = Environment.get("DATABASE_PORT") {
                databasePort = Int(testPort) ?? 5433
            } else {
                databasePort = 5433
            }
        default:
            databaseName = "swiftcafedb"
            databasePort = 5432
    }
    
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: databasePort,
        username: Environment.get("DATABASE_USERNAME") ?? "admin",
        password: Environment.get("DATABASE_PASSWORD") ?? "swiftcafeadmin",
        database: Environment.get("DATABASE_NAME") ?? databaseName
    ), as: .psql)
    
    app.http.server.configuration.port = 8090
//    app.http.server.configuration.hostname = "api.swiftcafe.local"
    
    try app.autoRevert().wait()
    
    // Running migrations
    app.migrations.add(CreateUser())
    app.migrations.add(CreateToken())
    app.migrations.add(CreateCart())
    app.migrations.add(CreateMenuSection())
    app.migrations.add(CreateFood())
    app.migrations.add(CreateCartEntry())
    app.migrations.add(CreateOptionGroup())
    app.migrations.add(CreateOption())
    app.migrations.add(CreateOptionEntry())
    app.migrations.add(CreateMenu())
    
    #warning("Dummy Data")
    app.migrations.add(CreateDummyUser())
    
    app.logger.logLevel = .debug
    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}

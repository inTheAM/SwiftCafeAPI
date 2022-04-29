import Fluent
import Vapor

func routes(_ app: Application) throws {
    let usersController = UsersController()
    let menuController = MenuController()

    try app.register(collection: usersController)
    try app.register(collection: menuController)
}

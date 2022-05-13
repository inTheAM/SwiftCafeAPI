import Fluent
import Vapor

func routes(_ app: Application) throws {
    let usersController = UsersController()
    let menuController = MenuController()
    let cartsController = CartsController()

    try app.register(collection: usersController)
    try app.register(collection: menuController)
    try app.register(collection: cartsController)
}

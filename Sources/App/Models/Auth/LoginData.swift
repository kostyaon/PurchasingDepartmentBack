import Vapor

struct LoginData: Content {
    let login: String
    let password: String
}

import UIKit
import PlaygroundSupport
import Foundation

// Delegate

// Делегатор - это тот, кто ставит задачу
// Тип делегата - протокол, которому должен соответствовать делегат
// Делегат - это тот, кто берет на себя обязанность выполнять задачу

struct Product {
    let title: String
    let price: Int
}

struct Position {
    let product: Product
    var count: Int
    var cost: Int {
        return product.price * count
    }
}

protocol CatalogDelegate {
    func addPosition(position: Position)
}

class Catalog {
    
    var products = [Product]()
    
    // Кто-то, кто подписан под делегата и этот кто-то будет опциональным типом.
    var delegate: CatalogDelegate?
    
    func addToCart(index: Int, count: Int) {
        if products.count > index {
            // Добавляем товар в корзину Cart
            
            if let delegate = delegate {
               
                let product = products[index]
                let position = Position(product: product, count: count)
                
                delegate.addPosition(position: position)
            }
            
        }
    }
    
}

class Cart: CatalogDelegate {
    
    private (set) var positions = [Position]()
    
    var cost: Int {
        var sum = 0
        
        for position in positions {
            sum += position.cost
        }
        
        return sum
    }
    
    func addPosition(position: Position) {
        self.positions.append(position)
    }
    
}

let catalog = Catalog()
let cart = Cart()

catalog.delegate = cart
print(cart.positions.count)

let prodK = Product(title: "Колбаса", price: 20)
let prodM = Product(title: "Молоко", price: 2)
let prodC = Product(title: "Сыр", price: 13)

catalog.products = [prodK, prodM, prodC]
catalog.addToCart(index: 0, count: 2)
catalog.addToCart(index: 1, count: 3)
catalog.addToCart(index: 2, count: 4)

cart.positions.count
cart.cost

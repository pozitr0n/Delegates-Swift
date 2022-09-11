import UIKit
import PlaygroundSupport
import Foundation

enum DogFeed: String {
    case regularFood = "Regular food for dogs"
    case dietFood = "Diet food for dogs"
}

enum DogToys: String {
    case dogBall = "Beautiful ball for dogs"
    case dogBone = "Beautiful bone for dogs"
}

protocol FeedDeliveryDelegate: AnyObject {
    
    func feedDeliveryByAddres(address: String, flat: Int, floor: Int)
    func feedDeliveryTime(date: String, time: String)
    func ordered(dogFeed: DogFeed?, dogToys: DogToys?)
    
}

class FeedShopHappyDog: FeedDeliveryDelegate {
    
    var currentAddress: String = ""
    var currentDeliveryTime: String = ""
    var currentArrayOfToys = [DogToys]()
    var currentArrayOfFeed = [DogFeed]()
    var orders = [String]()
    
    func feedDeliveryByAddres(address: String, flat: Int, floor: Int) {
        if (!address.isEmpty && flat != 0 && floor != 0) && currentAddress.isEmpty {
            currentAddress = "Address: " + address + ", flat: " + String(flat) + ", floor: " + String(floor)
        }
    }
    
    func feedDeliveryTime(date: String, time: String) {
        if (!date.isEmpty && !time.isEmpty) && currentDeliveryTime.isEmpty {
            currentDeliveryTime = "Date: " + date + ", time: " + time
        }
    }
    
    func ordered(dogFeed: DogFeed?, dogToys: DogToys?) {
        
        if dogFeed != nil {
            currentArrayOfFeed.append(dogFeed!)
        }
        
        if dogToys != nil {
            currentArrayOfToys.append(dogToys!)
        }
    }
    
    func createOrderWithFullInformation() {
    
        let currTime = NSDate()
        var allTheProducts: String = ""
        
        if currentArrayOfToys.count > 0 {
            for position in currentArrayOfToys {
                allTheProducts += " " + position.rawValue
            }
        }
        
        if currentArrayOfFeed.count > 0 {
            for position in currentArrayOfFeed {
                allTheProducts += " " + position.rawValue
            }
        }
        
        if !currentAddress.isEmpty && !currentDeliveryTime.isEmpty && !allTheProducts.isEmpty {

            orders.append("""
                          "Created order at \(currTime).
                          Products: \(allTheProducts)
                          Delivery address: \(currentAddress)
                          Delivery time: \(currentDeliveryTime)
                          """)
            
            allTheProducts = ""
            
            currentAddress = ""
            currentDeliveryTime = ""
            
            currentArrayOfToys = [DogToys]()
            currentArrayOfFeed = [DogFeed]()
            
            printLastOrder()
            
        }
        
    }
    
    func printLastOrder() {
        
        let lastOrder = orders[orders.count - 1]
        print(lastOrder)
    }
    
}

class WebsiteForOrderingFeedShopHappyDog {
 
    var delegate: FeedDeliveryDelegate
    
    init(delegate: FeedDeliveryDelegate) {
        self.delegate = delegate
    }
    
    func userSelectsPurchasesDogGoodsStore(feedForDog: DogFeed?, toysForDog: DogToys?) {
        delegate.ordered(dogFeed: feedForDog, dogToys: toysForDog)
    }
      
    func userEnteredAddres(yourAddres: String, flat: Int, floor: Int) {
        delegate.feedDeliveryByAddres(address: yourAddres, flat: flat, floor: floor)
    }
       
    func userEnteredDeliveryTime(deliveryDate: String, timeOfDelivery: String){
        delegate.feedDeliveryTime(date: deliveryDate, time: timeOfDelivery)
    }
    
}

let shop = FeedShopHappyDog()
let website = WebsiteForOrderingFeedShopHappyDog(delegate: shop)

website.userSelectsPurchasesDogGoodsStore(feedForDog: DogFeed.dietFood, toysForDog: DogToys.dogBone)
website.userEnteredAddres(yourAddres: "Wojciechowskiego", flat: 6, floor: 1)
website.userEnteredDeliveryTime(deliveryDate: "12.09.2022", timeOfDelivery: "15:00:00")

shop.createOrderWithFullInformation()

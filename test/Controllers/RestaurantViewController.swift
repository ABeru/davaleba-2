//
//  RestaurantViewController.swift
//  test
//
//  Created by Sandro Beruashvili on 7/8/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import UIKit
import SafariServices
import CoreData
import UserNotifications
class RestaurantViewController: UIViewController {
    @IBOutlet weak var restImg: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restCuisine: UILabel!
    @IBOutlet weak var restLoc: UILabel!
    @IBOutlet weak var restRate: UILabel!
    @IBOutlet weak var restPrice: UILabel!
    @IBOutlet weak var restDelivery: UILabel!
    @IBOutlet weak var restReserve: UILabel!
    @IBOutlet weak var restMenu: UIButton!
    @IBOutlet weak var restLink: UIButton!
    @IBOutlet weak var restNumber: UILabel!
    @IBOutlet weak var call: UIButton!
    @IBOutlet weak var heart: UIImageView!
    
    var restaurant: Restaurant?
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        askNotificationPermission()
        
        
        
        backView.layer.cornerRadius = 200
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view1.layer.shadowColor = UIColor.black.cgColor
        view1.layer.shadowOpacity = 1
        view1.layer.shadowOffset = .zero
        view1.layer.shadowRadius = 10
        view2.layer.shadowColor = UIColor.black.cgColor
        view2.layer.shadowOpacity = 1
        view2.layer.shadowOffset = .zero
        view2.layer.shadowRadius = 10
        view3.layer.shadowColor = UIColor.black.cgColor
        view3.layer.shadowOpacity = 1
        view3.layer.shadowOffset = .zero
        view3.layer.shadowRadius = 10
        call.layer.borderWidth = 5
        call.layer.borderColor = UIColor(red: 255/255, green: 113/255, blue: 125/255, alpha: 1).cgColor
      
        restName.text = restaurant!.name
        restCuisine.text = restaurant!.cuisines
        restLoc.text = restaurant!.location.address
        restRate.text = "Rating: \(restaurant!.userRating.aggregateRating)"
        restPrice.text = "Average Cost For Two: \(restaurant!.averageCostForTwo)"
        if restaurant!.r.hasMenuStatus.delivery == -1 {
            restDelivery.text = "Delivery: Unavailable"
        }
        else {
            restDelivery.text = "Delivery: Available"
        }
        restReserve.text = "Table Reservation: Available"
        restNumber.text = "(212)\(restaurant!.id)"
        restaurant!.thumb.downloadImage1 { (image) in
        DispatchQueue.main.async {
            self.restImg.image = image
        }}
        
    }
    func askNotificationPermission(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.sound,.badge]) { (granted, err) in
           
        }
    }
    
    func notification(){
        let center = UNUserNotificationCenter.current()
        

        let content = UNMutableNotificationContent()
        content.title = "\(restaurant!.name) has been added to favourites"
        content.body = "test"
       
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        
        center.add(request) { (err) in
            if err != nil {
                print(err ?? "")
            }
        }
        
        
    }
    @IBAction func backOn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func menuOn(_ sender: UIButton) {
        let url = URL(string: restaurant!.menuURL)
        let safari = SFSafariViewController(url: url!)
        safari.modalPresentationStyle = .popover
        present(safari, animated: true, completion: nil)
        
    }
    @IBAction func linkOn(_ sender: UIButton) {
        let url = URL(string: restaurant!.url)
        let safari = SFSafariViewController(url: url!)
        safari.modalPresentationStyle = .popover
        present(safari, animated: true, completion: nil)
        
    }
    @IBAction func callOn(_ sender: UIButton) {
        guard let url = URL(string: "tel://+2121234567") else {return}
        UIApplication.shared.open(url)
      
    }
    
    @IBAction func heartOn(_ sender: UIButton) {
        self.heart.image = UIImage(systemName: "heart.fill")
        heart.tintColor = UIColor(red: 255/255, green: 113/255, blue: 125/255, alpha: 1)
        addRest(id: Int32(self.restaurant!.r.resID))
          NotificationCenter.default.post(name: NSNotification.Name("update_favorite"), object: nil)
        notification()
    }
    

  
}
extension String {
      func downloadImage1(completion: @escaping (UIImage?) -> ()) {
              guard let url = URL(string: self) else {return}
              URLSession.shared.dataTask(with: url) { (data, res, err) in
                  guard let data = data else {return}
                  completion(UIImage(data: data))
              }.resume()
          }
    
}
extension RestaurantViewController {
 func addRest(id: Int32) {
       
       let context = AppDelegate.coreDataContainer.viewContext
       let entityDescription = NSEntityDescription.entity(forEntityName: "Rest", in: context)
       let add = Rest(entity: entityDescription!, insertInto: context)
       
    add.resId = id
       do {
           try context.save()
       } catch {
           
       }
   }
 }
extension RestaurantViewController: UNUserNotificationCenterDelegate {
    
    //for displaying notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //If you don't want to show notification when app is open, do something here else and make a return here.
        //Even you you don't implement this delegate method, you will not see the notification on the specified controller. So, you have to implement this delegate and make sure the below line execute. i.e. completionHandler.
        
        completionHandler([.alert, .badge, .sound])
    }
    
    // For handling tap and user actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "action1":
            print("Action First Tapped")
        case "action2":
            print("Action Second Tapped")
        default:
            break
        }
        completionHandler()
    }
    
}

//
//  SearchViewController.swift
//  test
//
//  Created by Sandro Beruashvili on 7/13/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import UIKit
import CoreData
import SafariServices
import NotificationCenter
class SearchViewController: UIViewController {
    @IBOutlet weak var restImage: UIImageView!
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restCuisine: UILabel!
    @IBOutlet weak var restLoc: UILabel!
    @IBOutlet weak var restRating: UILabel!
    @IBOutlet weak var restPrice: UILabel!
    @IBOutlet weak var restDelivery: UILabel!
    @IBOutlet weak var restReserv: UILabel!
    @IBOutlet weak var restPhone: UILabel!
    @IBOutlet weak var call: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var backView: UIView!
    var rest: Restaurant1?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
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
            
              restName.text = rest!.name
              restCuisine.text = rest!.cuisines
              restLoc.text = rest!.location.address
        restRating.text = "Rating: \(rest!.userRating.ratingText)"
              restPrice.text = "Average Cost For Two: \(rest!.averageCostForTwo)"
              if rest!.r.hasMenuStatus.delivery == -1 {
                  restDelivery.text = "Delivery: Unavailable"
              }
              else {
                  restDelivery.text = "Delivery: Available"
              }
              restReserv.text = "Table Reservation: Available"
              restPhone.text = "(212)\(rest!.id)"
               rest!.thumb.downloadImage4 { (image) in
                     DispatchQueue.main.async {
                         self.restImage.image = image
                     }}
        
    }
    func notification(){
     let center = UNUserNotificationCenter.current()
     

     let content = UNMutableNotificationContent()
     content.title = "\(rest!.name) has been added to favourites"
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
    @IBAction func heartOn(_ sender: UIButton) {
        self.heart.image = UIImage(systemName: "heart.fill")
        heart.tintColor = UIColor(red: 255/255, green: 113/255, blue: 125/255, alpha: 1)
       addRest1(id: Int32(self.rest!.r.resID))
        NotificationCenter.default.post(name: NSNotification.Name("update_favorite"), object: nil)
        notification()
    }
    @IBAction func menuOn(_ sender: UIButton) {
        let url = URL(string: rest!.menuURL)
               let safari = SFSafariViewController(url: url!)
               safari.modalPresentationStyle = .popover
               present(safari, animated: true, completion: nil)
        
    }
    @IBAction func siteOn(_ sender: UIButton) {
         let url = URL(string: rest!.url)
               let safari = SFSafariViewController(url: url!)
               safari.modalPresentationStyle = .popover
               present(safari, animated: true, completion: nil)
        
    }
    @IBAction func callOn(_ sender: UIButton) {
         guard let url = URL(string: "tel://+2121234567") else {return}
               UIApplication.shared.open(url)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension String {
      func downloadImage4(completion: @escaping (UIImage?) -> ()) {
              guard let url = URL(string: self) else {return}
              URLSession.shared.dataTask(with: url) { (data, res, err) in
                  guard let data = data else {return}
                  completion(UIImage(data: data))
              }.resume()
          }
    
}
extension SearchViewController {
 func addRest1(id: Int32) {
       
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
extension SearchViewController: UNUserNotificationCenterDelegate {
    
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

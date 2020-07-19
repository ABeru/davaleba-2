//
//  test.swift
//  test
//
//  Created by Sandro Beruashvili on 7/5/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import UIKit
import SkeletonView
class NearbyController: UIViewController {
    var lat: Double?
    var lng: Double?
    var some = [NearbyRestaurant]()
    let transition = PopAnimator()
    var selectedItem = 0
    var selectedCell: NearbyRestaurant?
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var RestTable: UITableView!
    
    let nearByViewModel = NearByViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        let secondTab = (self.tabBarController?.viewControllers?.last)! as! MapController
//        secondTab.lat = lat
//        secondTab.lon = lng
        
        print("ok",lat, lng)
       
        RestTable.rowHeight = 214
        RestTable.estimatedRowHeight = 214
        RestTable.delegate = self
        RestTable.dataSource = self
        RestTable.backgroundColor = .clear
         RestTable.isSkeletonable = true
        RestTable.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(red: 255/255, green: 113/255, blue: 125/255, alpha: 1)), animation: nil, transition: .crossDissolve(0.1))
        headView.layer.cornerRadius = 150
        headView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        nearByViewModel.fetch(lat!, lng!){(sm) in
            self.some.append(contentsOf: sm.nearbyRestaurants)
            for l in sm.nearbyRestaurants {
                Locations.sharedInstance.array.append(((l.restaurant.location.latitude as NSString).doubleValue,(l.restaurant.location.longitude as NSString).doubleValue, l.restaurant.name,l.restaurant.cuisines))
            }
            DispatchQueue.main.async {
                self.RestTable.reloadData()
        
                self.RestTable.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
            }
             
            
        }
        
        transition.dismissCompletion = { [weak self] in
                       guard
                        let selectedIndexPathCell = self?.RestTable.indexPathForSelectedRow,
                        let selectedCell = self?.RestTable.cellForRow(at: selectedIndexPathCell)
                           as? NearByCell
                         else {
                           return
                       }

                       selectedCell.isHidden = false
                     }
        }
   

      

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if let ImageVC = segue.destination as? RestaurantViewController{
                ImageVC.restaurant = some[selectedItem].restaurant
                ImageVC.transitioningDelegate = self
                ImageVC.modalPresentationStyle = .fullScreen
               }
           }

}

extension NearbyController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = indexPath.row
        performSegue(withIdentifier: "rest", sender: nil)
    }
}
extension NearbyController: SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return some.count
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NearByCell
      
        cell.backgroundColor = .clear
        cell.restThumb.layer.cornerRadius = 30
        cell.view1.layer.cornerRadius = 30
        cell.openNow.layer.cornerRadius = 50
        cell.openNow.layer.backgroundColor = UIColor.green.cgColor
        cell.restName.text = some[indexPath.row].restaurant.name
        some[indexPath.row].restaurant.thumb.downloadImage { (image) in
                                 DispatchQueue.main.async {
                                    cell.restThumb.image = image
                                 }}
        cell.restCuisine.text = some[indexPath.row].restaurant.cuisines
        cell.restLocation.text = some[indexPath.row].restaurant.location.address
        cell.restPrice.text = "Avg:\(some[indexPath.row].restaurant.averageCostForTwo)$"
        cell.restRating.text = "\(some[indexPath.row].restaurant.userRating.aggregateRating)(\(some[indexPath.row].restaurant.userRating.votes)) \(some[indexPath.row].restaurant.userRating.ratingText)"
          return cell    }
    
    
}
extension NearbyController: UIViewControllerTransitioningDelegate {
      func animationController(
          forPresented presented: UIViewController,
          presenting: UIViewController, source: UIViewController)
            -> UIViewControllerAnimatedTransitioning? {

                guard
                    let selectedIndexPathCell = RestTable.indexPathForSelectedRow,
                    let selectedCell = RestTable.cellForRow(at: selectedIndexPathCell)
                    as? NearByCell,
                  let selectedCellSuperview = selectedCell.superview
                  else {
                    return nil
                }

                transition.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
                transition.originFrame = CGRect(
                  x: transition.originFrame.origin.x + 20,
                  y: transition.originFrame.origin.y + 20,
                  width: transition.originFrame.size.width - 40,
                  height: transition.originFrame.size.height - 40
                )

                transition.presenting = true

                selectedCell.isHidden = true

          return transition
        }

        func animationController(forDismissed dismissed: UIViewController)
            -> UIViewControllerAnimatedTransitioning? {
                transition.presenting = false
                return transition


        }

    }
extension String {
      func downloadImage(completion: @escaping (UIImage?) -> ()) {
              guard let url = URL(string: self) else {return}
              URLSession.shared.dataTask(with: url) { (data, res, err) in
                  guard let data = data else {return}
                  completion(UIImage(data: data))
              }.resume()
          }
    
}

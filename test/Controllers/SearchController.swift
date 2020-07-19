//
//  SearchController.swift
//  test
//
//  Created by Sandro Beruashvili on 7/12/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet weak var search1: UISearchBar!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var sortImg: UIImageView!
    @IBOutlet weak var someView: UIView!
    var searchRests: [RestaurantElement] = []
    var viewHide = true
    var selectedItem = 0
    
    let searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search1.delegate = self
        searchTable.delegate = self
        searchTable.dataSource = self
        sortImg.isUserInteractionEnabled = true
          sortImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showView)))
    }
    
    @objc func showView() {
        print(#function)
        if viewHide {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.15, options: [], animations: {
                self.searchTable.frame.origin.y = self.view.safeAreaLayoutGuide.layoutFrame.minY + 187
             
                self.sortImg.transform = CGAffineTransform(rotationAngle: .pi)
                
            }) { (f) in
                self.viewHide = false
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.15, options: [], animations: {
                self.searchTable.frame.origin.y = self.view.safeAreaLayoutGuide.layoutFrame.minY + 60
             
                self.sortImg.transform = CGAffineTransform(rotationAngle: (.pi*2))
                
            }) { (f) in
                self.viewHide = true
            }
        }
    }
    @IBAction func priceHigh(_ sender: UIButton) {
          searchRests.sort(by: {$0.restaurant.averageCostForTwo > $1.restaurant.averageCostForTwo})
          self.searchTable.frame.origin.y = self.view.safeAreaLayoutGuide.layoutFrame.minY + 60
          self.sortImg.transform = CGAffineTransform(rotationAngle: (.pi*2))
        searchTable.reloadData()
    }
    @IBAction func byRating(_ sender: UIButton) {
        searchRests.sort(by: {$0.restaurant.userRating.votes > $1.restaurant.userRating.votes})
          self.searchTable.frame.origin.y = self.view.safeAreaLayoutGuide.layoutFrame.minY + 60
          self.sortImg.transform = CGAffineTransform(rotationAngle: (.pi*2))
        searchTable.reloadData()
    }
    @IBAction func priceLow(_ sender: UIButton) {
          searchRests.sort(by: {$0.restaurant.averageCostForTwo < $1.restaurant.averageCostForTwo})
          self.searchTable.frame.origin.y = self.view.safeAreaLayoutGuide.layoutFrame.minY + 60
          self.sortImg.transform = CGAffineTransform(rotationAngle: (.pi*2))
        searchTable.reloadData()
    }
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                  if let ImageVC = segue.destination as? SearchViewController{
                    ImageVC.rest = searchRests[selectedItem].restaurant
             
                   ImageVC.modalPresentationStyle = .fullScreen
                  }
              }}
extension SearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = indexPath.row
        performSegue(withIdentifier: "searchgo", sender: nil)
    }
}
extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchRests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "search", for: indexPath) as! SearchCell
        cell.restName.text = searchRests[indexPath.row].restaurant.name
        cell.restLoc.text = searchRests[indexPath.row].restaurant.location.address
        cell.restRate.text = searchRests[indexPath.row].restaurant.userRating.ratingText
        cell.restPrice.text = "Avg: \(searchRests[indexPath.row].restaurant.averageCostForTwo)$"
        cell.restCuisine.text = searchRests[indexPath.row].restaurant.cuisines
        searchRests[indexPath.row].restaurant.thumb.downloadImage { (image) in
        DispatchQueue.main.async {
            cell.restImg.image = image
        }}
        return cell
        
    }
    
    
}
extension SearchController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    if searchText.isEmpty == false {
        
        searchViewModel.fetch(searchText) { response in
            self.searchRests.append(contentsOf: response.restaurants)
             DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                 self.searchTable.reloadData()
             })
                     
        }
        
    } else {
        searchRests.removeAll()
        DispatchQueue.main.async {
            self.searchTable.reloadData()
        }
    }
        
    }
}
extension String {
      func downloadImage3(completion: @escaping (UIImage?) -> ()) {
              guard let url = URL(string: self) else {return}
              URLSession.shared.dataTask(with: url) { (data, res, err) in
                  guard let data = data else {return}
                  completion(UIImage(data: data))
              }.resume()
          }
    
}

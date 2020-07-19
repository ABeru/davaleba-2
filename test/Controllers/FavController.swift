//
//  FavController.swift
//  test
//
//  Created by Sandro Beruashvili on 7/10/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import UIKit
import CoreData
class FavController: UIViewController {
    var selectedIndex = -1
    var selectedItem = 0
    let transition = PopAnimator()
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var favTable: UITableView!
    var favRests = [Restaurant]()
    
    let favoriteViewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(didRecieveFavorite(with:)),
        name: NSNotification.Name("update_favorite"),
        object: nil)
        favTable.delegate = self
        favTable.dataSource = self
        favTable.rowHeight = UITableView.automaticDimension
        favTable.backgroundColor = .clear
        view2.layer.cornerRadius = 150
        view2.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        print("ok")
        for n  in fetchRest() {
            print(n.resId)

            favoriteViewModel.fetch(n.resId) { response in
                self.favRests.append(response)
                print("okey")
                DispatchQueue.main.async {
                    self.favTable.reloadData()
                }
            }
        }
        
       
        
        // cade aba
        // gavt
        // anu amatebs mara tableviewze ar achens da mere meorejer ro davlaunchav mere achens
        // mand shedis davteste eg
    }
  @objc func didRecieveFavorite(with notification: Notification) {
    favRests.removeAll()
     for item in fetchRest() {
        favoriteViewModel.fetch(item.resId) { response in
            self.favRests.append(response)
            print("okey")
            DispatchQueue.main.async {
                self.favTable.reloadData()
            }
        }
      }
 }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ImageVC = segue.destination as? RestaurantViewController{
            ImageVC.restaurant = favRests[selectedItem]
           
            ImageVC.modalPresentationStyle = .fullScreen
        }
    }}
extension FavController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedIndex {
            return 316
        }
        return 316
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav", for: indexPath) as! FavCell
        
        if selectedIndex == indexPath.row {
            selectedIndex = -1
            
        } else {
            
            selectedIndex = indexPath.row
        }
        
        favTable.reloadRows(at: [indexPath], with: .automatic)
    }
    
}


extension FavController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favRests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav", for: indexPath) as! FavCell
        cell.didTapMoreInfo = { [weak self] in
            self?.selectedItem = indexPath.row
            self?.performSegue(withIdentifier: "favgo", sender: self)
        }
        cell.didTapMoreInfo1 = { [weak self] in
            self?.selectedItem = indexPath.row
            //  self!.deleteExistingRest(note: self!.fetchRest()[indexPath.row])
            // qvemot da zemot daxede reloads ra rato ar amatebs egreve?
            // sad aba?
            self?.deleteExistingRest(note: (self?.fetchRest()[indexPath.row])!, completion: { (deleted) in
                if deleted {
                    self?.favRests.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .left)
                }
            })
            
        }
        cell.backgroundColor = .clear
        cell.restImage.layer.cornerRadius = 30
        cell.view1.layer.cornerRadius = 30
        cell.restCuisine.text = favRests[indexPath.row].cuisines
        cell.restName.text = favRests[indexPath.row].name
        cell.restLoc.text = favRests[indexPath.row].location.address
        cell.restPrice.text = "Avg: \(favRests[indexPath.row].averageCostForTwo)$"
        cell.restRate.text = "\(favRests[indexPath.row].userRating.aggregateRating)(\(favRests[indexPath.row].userRating.votes)) \(favRests[indexPath.row].userRating.ratingText)"
        favRests[indexPath.row].thumb.downloadImage { (image) in
            DispatchQueue.main.async {
                cell.restImage.image = image
            }}
        
        return cell
    }
    
    
}
extension FavController {
    func fetchRest() -> [Rest] {
        let context = AppDelegate.coreDataContainer.viewContext
        let fetchRequest = NSFetchRequest<Rest>(entityName: "Rest")
        do {
            let result = try context.fetch(fetchRequest)
            let id = result as [Rest]
            return id
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        return []
    }  }
extension String {
    func downloadImage2(completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: self) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            completion(UIImage(data: data))
        }.resume()
    }
    
}

extension FavController {
    func deleteExistingRest(note: Rest, completion: @escaping (Bool) -> ()) {
        let context = AppDelegate.coreDataContainer.viewContext
        context.delete(note)
        
        do {
            try context.save()
            completion(true)
        } catch let error {
            debugPrint(error)
        }
    }
}
// ara shen shecvale da mere undo vuqeni vtestavdi ragacas da redo vegar vqeni
// gasagebia wait

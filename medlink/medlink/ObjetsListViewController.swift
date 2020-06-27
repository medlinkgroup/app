//
//  ObjetsListViewController.swift
//  medlink
//
//  Created by cylia boukhiba on 27/06/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit

class ObjetsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  

    @IBOutlet weak var tableview_list_objects: UITableView!
      public static let objetcsTableViewCellId = "otvc"
    var objetService: ObjetService{
             
          return ObjetApiService()
      }
    var objectDetail: Objet!
       var DoctorUID: String = ""
       var objetEdit: Objet!
       var objets: [Objet] = [] {
              didSet {
                self.tableview_list_objects.reloadData()
            }
        }
    override func viewDidAppear(_ animated: Bool) {
        self.objetService.getAll { (objets) in
            print(objets)
            
            self.objets = objets
            // filter just doctorId
            
            print(self.objets)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview_list_objects.rowHeight = 120
        self.tableview_list_objects.register(UINib(nibName: "ObjetsTableViewCell", bundle: nil), forCellReuseIdentifier: ObjetsListViewController.objetcsTableViewCellId)
        self.tableview_list_objects.dataSource = self
        self.tableview_list_objects.delegate = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objets.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: ObjetsListViewController.objetcsTableViewCellId, for: indexPath) as! ObjetsTableViewCell
          let objet = self.objets[indexPath.row]
          cell.label_object_name.text = objet.name
          return cell
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

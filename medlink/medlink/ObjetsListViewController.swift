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
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

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
      
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
              print("***************You tapped cell number \(indexPath.row).")
          }
      
 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                 let objet = self.objets[indexPath.row]
                 if editingStyle == UITableViewCell.EditingStyle.delete {
               
                 let refreshAlert = UIAlertController(title: NSLocalizedString("delete", comment: ""), message: NSLocalizedString("confirm_delete", comment: ""), preferredStyle: UIAlertController.Style.alert)
                 refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { (action: UIAlertAction!) in do {
                          
                          self.objetService.delete( id: objet._id){
                                                       (success) in print(success)
                                              
                             self.viewDidAppear(true)
                                                   }
                          }
                          
                         }))
                
                 refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler:nil ))
                      self.present(refreshAlert, animated: true, completion: nil)
                }
       }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
       {
              let closeAction = UIContextualAction(style: .normal, title:  NSLocalizedString("modify", comment: ""), handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
              let objet = self.objets[indexPath.row]
              self.objetEdit = objet
                  
              let next = EditObjetViewController().newInstance(detail: self.objetEdit)
                 
                  self.navigationController?.pushViewController(next, animated: true)
               })
               closeAction.image = UIImage(named: NSLocalizedString("update", comment: ""))
               closeAction.backgroundColor = .lightGray
       
               return UISwipeActionsConfiguration(actions: [closeAction])
       
      }


}

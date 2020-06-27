
//
//  DocDashboardListViewController.swift
//  medlink
//
//  Created by Fabiana Montiel on 05/05/2020.
//  Copyright © 2020 Fabiana Montiel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class DocDashboardListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var label_dashboard: UILabel!
    @IBOutlet var label_consultations: UILabel!
    @IBOutlet var img_add_patient: UIImageView!
    @IBOutlet var img_add_consultation: UIImageView!
    @IBOutlet weak var mapView: UIButton!
    @IBOutlet weak var btn_add_object: UIButton!
    
    var DoctorUID: String = ""
    enum TableSection: Int {
        case future, past
    }
    let SectionHeaderHeight: CGFloat = 30
    var consultationEdit: Consultation!
    var data = [TableSection: [Consultation]]()
    
    var consultationDetail: Consultation!
    
    public static let consultationsTableViewCellId = "ctvc"
    
    @IBOutlet var consultationsTableView: UITableView!
    
    var consultations: [Consultation] = [] {
        didSet {
            self.consultationsTableView.reloadData()
        }
    }
    var consultationService: ConsultationService{
      //  return ConsultationMockService()
        return ConsultationAPIService()
    }
    
     override func viewDidLoad() {
         super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) 
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.action_add_patient(gesture:)))

        // add it to the image view;
        img_add_patient.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        img_add_patient.isUserInteractionEnabled = true
        
        
        // create tap gesture recognizer
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.action_add_consultation(gesture:)))

        // add it to the image view;
        img_add_consultation.addGestureRecognizer(tapGesture2)
        // make sure imageView can be interacted with by user
        img_add_consultation.isUserInteractionEnabled = true
        
        
        
        label_dashboard.text = NSLocalizedString("dashboard", comment: "")
        label_consultations.text = NSLocalizedString("list_consultations", comment: "")
        
        self.consultationsTableView.rowHeight = 100
        self.consultationsTableView.register(UINib(nibName: "ConsultationsTableViewCell", bundle: nil),
                                             forCellReuseIdentifier: DocDashboardListViewController.consultationsTableViewCellId)
        consultationsTableView.dataSource = self
        consultationsTableView.delegate = self
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let db = Firestore.firestore()
               if let user = Auth.auth().currentUser{
                   let docRef = db.collection("users").document(user.uid)
                   self.DoctorUID = user.uid
                   print(docRef)
               
                  docRef.getDocument { (document, error) in
                       
                   
                     if let document = document, document.exists {
                     
                          print(document.data()!)
                       self.DoctorUID = document["uid"]! as! String
                          } else {
                              print("DOCTOR UID NOT FOUND : Document does not exist")
                          }
                      }
                   } else {
                       //fatalError(" Erreur : aucun user connect")
                       print("no user connected")
                   }
               
    }
         
       
         // Do any additional setup after loading the view.
    override func viewWillAppear(_ animated: Bool) {
        self.consultationService.getAll{(consultations)in
            self.consultations = consultations.filter({$0.doctorUid == self.DoctorUID})
            print (consultations.count)
            self.sortData()
            self.consultationsTableView.reloadData()
        }
    }
    func sortData() {
        let date  = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let result = formatter.string(from: date)
        data[.future] = consultations.filter({$0.date >= result })
        data[.past] = consultations.filter({$0.date < result})
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
      if let tableSection = TableSection(rawValue: section), let consultationData = data[tableSection] {
        return consultationData.count
      }
      return 0
    }
    
    // creation des sections
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
      view.backgroundColor = UIColor(red: 0.70, green:0.77, blue:0.78, alpha: 1.00)
        
      let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width + 50, height: SectionHeaderHeight))
        label.font  = UIFont(name:"Avenir", size:15)
        label.textColor = UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00)
      if let tableSection = TableSection(rawValue: section) {

        switch tableSection {
        case .future:
          label.text = NSLocalizedString("future", comment: "")
        case .past:
          label.text = NSLocalizedString("past", comment: "")
       
        default:
          label.text = ""
        }
      }
      view.addSubview(label)
      return view
    }

    
    // remplissage des cells
              func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                  let cell = tableView.dequeueReusableCell(withIdentifier: DocDashboardListViewController.consultationsTableViewCellId, for: indexPath) as! ConsultationsTableViewCell
               // ajout des events dans chaque section
               if let tableSection = TableSection(rawValue: indexPath.section), let consultation = data[tableSection]?[indexPath.row] {
               
                cell.label_patient.text = consultation.title
                 //    cell.sizeToFit()
                cell.label_date.text = formatDate(date: consultation.date)
    
                   
               }
                return cell
              }
       
           
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          if let tableSection = TableSection(rawValue: indexPath.section) {
              let consultation = data[tableSection]?[indexPath.row]
              self.consultationDetail = consultation
              let next = LineGraphViewController().newInstance(detail: consultationDetail)
              self.navigationController?.pushViewController(next, animated: true)
    
          }
      }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
              let consultation = self.consultations[indexPath.row]
              if editingStyle == UITableViewCell.EditingStyle.delete {
            
              let refreshAlert = UIAlertController(title: NSLocalizedString("delete", comment: ""), message: NSLocalizedString("confirm_delete", comment: ""), preferredStyle: UIAlertController.Style.alert)
              refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { (action: UIAlertAction!) in do {
                       
                       self.consultationService.delete( id: consultation._id){
                                                    (success) in print(success)
                                                      //self.events.remove(at: indexPath.row)
                                                      //tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                          self.viewWillAppear(true)
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
            let consultation = self.consultations[indexPath.row]
                print(indexPath.row)
            self.consultationEdit = consultation
                
            let next = EditConsultationViewController().newInstance(detail: self.consultationEdit)
                // self.navigationController?.pushViewController(next, animated: true)
                 //let editEventViewController = EventsEditViewController()
                self.navigationController?.pushViewController(next, animated: true)
             })
             closeAction.image = UIImage(named: NSLocalizedString("update", comment: ""))
             closeAction.backgroundColor = .lightGray
     
             return UISwipeActionsConfiguration(actions: [closeAction])
     
    }
          func formatDate(date: String) -> String {
              let dateFormatterGet = DateFormatter()
              dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

              let dateFormatter = DateFormatter()
              dateFormatter.dateStyle = .medium
              dateFormatter.timeStyle = .none
              dateFormatter.locale    = Locale(identifier: "FR-fr")

              let dateObj: Date? = dateFormatterGet.date(from: date)

              return dateFormatter.string(from: dateObj!)
           }
          
    
   
    @objc func action_add_patient(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            self.navigationController?.pushViewController(AddPatientViewController(),animated:true)
            //Here you can initiate your new ViewController

        }
    }
    
    @IBAction func map_view(_ sender: Any) {
        let next = PatientsMapViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }
    @objc func action_add_consultation(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            self.navigationController?.pushViewController(AddConsultationViewController(),animated:true)
            //Here you can initiate your new ViewController

        }
    }

    
    // API : https://medlinkapi.herokuapp.com/
    

}

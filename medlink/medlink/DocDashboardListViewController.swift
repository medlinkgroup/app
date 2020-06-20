
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
    
    
    enum TableSection: Int {
        case future, past
    }
    let SectionHeaderHeight: CGFloat = 30
    
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
        return ConsultationMockService()
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
        
        self.consultationsTableView.rowHeight = 120
        self.consultationsTableView.register(UINib(nibName: "ConsultationsTableViewCell", bundle: nil),
                                             forCellReuseIdentifier: DocDashboardListViewController.consultationsTableViewCellId)
        consultationsTableView.dataSource = self
        consultationsTableView.delegate = self
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
         
       
         // Do any additional setup after loading the view.
    override func viewWillAppear(_ animated: Bool) {
        self.consultationService.getAll{(consultations)in
            self.consultations = consultations
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
      view.backgroundColor = UIColor(red: 0.81, green:0.93, blue:0.98, alpha: 1.00)
        
      let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width + 50, height: SectionHeaderHeight))
        label.font  = UIFont(name:"Avenir", size:15)
        label.textColor = UIColor(red: 0.44, green: 0.51, blue:0.53, alpha: 1.00)
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
    
    @objc func action_add_consultation(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            self.navigationController?.pushViewController(AddConsultationViewController(),animated:true)
            //Here you can initiate your new ViewController

        }
    }

    
    // API : https://medlinkapi.herokuapp.com/
    

}

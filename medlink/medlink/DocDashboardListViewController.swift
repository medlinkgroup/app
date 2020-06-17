
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
        
        self.consultationsTableView.rowHeight = 120
        self.consultationsTableView.register(UINib(nibName: "ConsultationsTableViewCell", bundle: nil),
                                             forCellReuseIdentifier: DocDashboardListViewController.consultationsTableViewCellId)
        consultationsTableView.dataSource = self
        consultationsTableView.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
      view.backgroundColor = UIColor(red: 26.0/255.0, green: 113.0/255.0, blue: 200.0/255.0, alpha: 1)
        
      let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width + 50, height: SectionHeaderHeight))
        label.font  = UIFont(name:"FontAwesome", size:15)
      if let tableSection = TableSection(rawValue: section) {

        switch tableSection {
        case .future:
          label.text = "Futures"
        case .past:
          label.text = "pasts"
       
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
          
           
    @IBOutlet var label_consultations: UILabel!
    @IBOutlet var label_dashboard: UILabel!
    
    
    // API : https://medlinkapi.herokuapp.com/
    

}

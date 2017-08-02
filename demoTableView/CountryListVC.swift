//
//  CountryListVC.swift
//  demoTableView
//
//  Created by techmaster on 7/24/17.
//  Copyright © 2017 techmaster. All rights reserved.
//

import UIKit

class CountryListVC: UITableViewController, ExpandableHeaderViewDelegate {
    var arrayKeys = [String]()
    
    var dictCountry = NSMutableDictionary()
    
    var dictdata: NSArray!
    
    var status : Bool = false
    
    var arrayAll = [[String : Bool]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.creatDataWithName()
        
        self.title = "List Continents"
        
            }
    func creatDataWithName() {
        
        var path: String = ""
        
        path = Bundle.main.path(forResource: "data", ofType: "plist")!//Mở file plist
        
        dictdata = NSArray(contentsOfFile: path)
        
        for i in 0..<dictdata.count {
            
            let data = dictdata[i] as! NSDictionary
            
            let value = data.value(forKey: "continent") as! String
            
            arrayKeys.append(value) //Thêm data valua có key là "continent" -section
            
            let dataCountry = data.value(forKey: "countries") as! NSArray
            
            dictCountry.setValue(dataCountry, forKey: value)
            
            let dic = [value: false]
            
            self.arrayAll.append(dic)
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int { //Số section tương ứng với arrayKeys
        
        return arrayKeys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionTitle = arrayKeys[section]
        
        let sectionObject = dictCountry.object(forKey: sectionTitle) as! NSArray
        
        return sectionObject.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if (cell == nil) {
            
            cell  = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        }
        let sectionTitle = arrayKeys[indexPath.section]
        
        let sectionValuaCountries = dictCountry[sectionTitle] as! NSArray
        
        let countryObject = sectionValuaCountries[indexPath.row] as! NSDictionary
        
        cell.textLabel?.text = countryObject.value(forKey: "coutry") as! String? //Hiển thị tên nước
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayKeys[section] //hearder section tương ứng với các arrKeys
    }
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = UIColor.gray //thanh section có màu xanh
//        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//        header.textLabel?.textColor = UIColor.white//các textlable trong row có màu trắng
//    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
//        print(All_Array[section])
//        print()
        arrayAll[section][arrayKeys[section]] = !arrayAll[section][arrayKeys[section]]!
        
        tableView.beginUpdates()
        
        let sectionTitle = arrayKeys[section]
        
        let sectionValueCountry = dictCountry[sectionTitle] as! NSArray
        
        for i in 0 ..< sectionValueCountry.count{
            
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
        
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        
        header.customInit(title: arrayKeys[section],section: section, delegate: self)
        
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayAll[indexPath.section][arrayKeys[indexPath.section]] == true {
            
            return 50//chiều cao 1 section
            
        }else{
            
            return 0.5 //khoảng cách giữa các section
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "ShowDetail") {
            
            let detail = segue.destination as! DetailVC
            
            let selectedRowIndex: IndexPath = self.tableView.indexPathForSelectedRow!
            
            let sectionTitle = arrayKeys[selectedRowIndex.section]
            
            let sectionValueConutry = dictCountry[sectionTitle] as! NSArray
            
            let countryObject = sectionValueConutry[selectedRowIndex.row] as! NSDictionary
            
            detail.dictCountry = countryObject as! NSMutableDictionary
       
        }
    }
}


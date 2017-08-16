//
//  VBExpandVC.swift
//  VBExpand_Tableview
//
//  Created by Vimal on 8/16/17.
//  Copyright © 2017 Crypton. All rights reserved.
//

import UIKit

class VBExpandVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var myTableView: UITableView!
    var expandTableview:VBHeader = VBHeader()
    var cell : VCExpandCell!
    var arrStatus:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<10 // pass your array count
        {
            self.arrStatus.add("0")
        }

        self.myTableView?.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        expandTableview = Bundle.main.loadNibNamed("VBHeader", owner: self, options: nil)?[0] as! VBHeader
        let layer = expandTableview.viewHeader.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 2
        layer.cornerRadius = 10.0
        expandTableview.lblDate.text = Date().toString(format:"EEEE, MMM d, yyyy")
        expandTableview.btnExpand.tag = section
        expandTableview.btnExpand.addTarget(self, action: #selector(VBExpandVC.headerCellButtonTapped(_sender:)), for: UIControlEvents.touchUpInside)

        let str:String = arrStatus[section] as! String
        if str == "0"
        {
            UIView.animate(withDuration: 2) { () -> Void in
                self.expandTableview.imgArrow.image = UIImage(named :"ExpandDownArrow")
                let angle =  CGFloat(M_PI * 2)
                let tr = CGAffineTransform.identity.rotated(by: angle)
                self.expandTableview.imgArrow.transform = tr
            }
        }
        else
        {
            UIView.animate(withDuration: 2) { () -> Void in
                self.expandTableview.imgArrow.image = UIImage(named :"ExpandUpArrow")
                let angle =  CGFloat(M_PI * 2)
                let tr = CGAffineTransform.identity.rotated(by: angle)
                self.expandTableview.imgArrow.transform = tr
            }
        }

        return expandTableview
    }
    func headerCellButtonTapped(_sender: UIButton)
    {
        let str:String = arrStatus[_sender.tag] as! String
        if str == "0"
        {
            arrStatus[_sender.tag] = "1"

        }
        else
        {
            arrStatus[_sender.tag] = "0"
        }
        myTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        //Return header height as per your header hieght of xib
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{

        let str:String = arrStatus[section] as! String

        if str == "0"
        {
            return 0
        }
        return  1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VCExpandCell
       
        return cell;
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        //Return row height as per your cell in tableview
        return 111
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}


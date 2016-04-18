//
//  ViewController.swift
//  taskList2
//
//  Created by yangyixin on 16/4/15.
//  Copyright © 2016年 yangyixin. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController{
    
    var toDoItems:Array<Dictionary<String,String>> = Array()
    
    override func viewDidAppear(animated: Bool) {
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let itemListFromUserDefaults:Array<Dictionary<String,String>>? = userDefaults.objectForKey("itemList") as? Array
        if(itemListFromUserDefaults != nil){
            toDoItems = itemListFromUserDefaults!
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //In a storybord-based application,you will off want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        //Get the new view controller using [segue destinationViewContoller]
        //Pass the selected object to the new view contoller
        if(segue.identifier == "userDetailData"){
            let selectedIndexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
            let detailViewController:DetailViewController = segue.destinationViewController as! DetailViewController
            var toDoData: Dictionary<String,String> = toDoItems[selectedIndexPath.row]
            toDoData["index"] = "\(selectedIndexPath.row)"
            detailViewController.toDoData = toDoData
        }
    }
    
    //dataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as UITableViewCell
        var toDoItem:Dictionary<String,String> = toDoItems[indexPath.row]
        cell.textLabel!.text = toDoItem["itemTitle"]
    
        return cell
    }
}


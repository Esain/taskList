//
//  DetailViewController.swift
//  taskList2
//
//  Created by yangyixin on 16/4/15.
//  Copyright © 2016年 yangyixin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var toDoData: Dictionary<String,String> = Dictionary()
    
    @IBOutlet weak var notesView: UITextView!
    @IBOutlet weak var titleText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.userInteractionEnabled = false
        notesView.userInteractionEnabled = false
        
        titleText.text = toDoData["itemTitle"]
        notesView.text = toDoData["itemNotes"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteItem(sender: AnyObject) {
        let userDefaluts:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let itemList:Array<Dictionary<String,String>> = userDefaluts.objectForKey("itemList") as! Array
        var newItemList: Array<Dictionary<String,String>> = Array()
        
        for item:Dictionary<String,String> in itemList {
            newItemList.append((item))
        }
        newItemList.removeAtIndex(Int(toDoData["index"]!)!)
        userDefaluts.removeObjectForKey("itemList")
        userDefaluts.setObject(newItemList, forKey: "itemList")
        userDefaluts.synchronize()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

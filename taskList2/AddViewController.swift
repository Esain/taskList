//
//  AddViewController.swift
//  taskList2
//
//  Created by yangyixin on 16/4/15.
//  Copyright © 2016年 yangyixin. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate {

    @IBOutlet weak var titleTextFiled: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //add tapGesture to imageView
        let tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "chooseImage:")
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.userInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func addButn(sender: AnyObject) {
        let userDefauls:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var itemList:Array<Dictionary<String,String>>? = userDefauls.objectForKey("itemList") as? Array
        
        var dataSet: Dictionary<String,String> = Dictionary();
        dataSet["itemTitle"] = titleTextFiled.text!
        dataSet["itemNotes"] = notesTextView.text!
        
        if(itemList != nil){ // data already avaliable
            itemList!.append(dataSet)
            userDefauls.removeObjectForKey("itemList")
        }else{// This is the first todo item in the list
            itemList = Array()
            itemList!.append(dataSet)
        }
        
        userDefauls.setObject(itemList, forKey: "itemList")
        userDefauls.synchronize()
        self.navigationController!.popToRootViewControllerAnimated(true)
//        itemList.append(dataSet)
    }

    func chooseImage(recognizer: UITapGestureRecognizer) {
        
        if #available(iOS 8.0, *) {
            let alertContoller: UIAlertController = UIAlertController(title: "是否打开相册", message: nil, preferredStyle:UIAlertControllerStyle.Alert)
            let okButton:UIAlertAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: { (btn) -> Void in
                alertContoller.dismissViewControllerAnimated(true, completion: nil)
                //show photolibray
                let imagePicker:UIImagePickerController = UIImagePickerController()
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.delegate = self
                
                self.presentViewController(imagePicker, animated: true, completion:nil)

            })
            
            let cancelButton:UIAlertAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Default, handler: { (btn) -> Void in
                alertContoller.dismissViewControllerAnimated(true, completion: nil)
            })
            alertContoller.addAction(okButton)
            alertContoller.addAction(cancelButton)
            self.presentViewController(alertContoller,animated: true,completion: nil)
        } else {
            // Fallback on earlier versions
            let alertView: UIAlertView = UIAlertView(title: "simple Alert", message: "this is a simple alert", delegate: self, cancelButtonTitle: "ok")
            alertView.show()
        }
       
            }
    
    @IBAction func choosePic(sender: AnyObject) {
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.delegate = self
        
        self.presentViewController(imagePicker, animated: true, completion:nil)
    }
    //pick confirm
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        let pickedImage:UIImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
//        let imageData
        imageView.image = scaleImageWidth(pickedImage,newSize: CGSize.init(width: 111,height: 111))

        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    //pick cancel
//     func imagePickerControllerDidCancel(picker: UIImagePickerController){
//       print("cancel")
//        
//    }
    
    func scaleImageWidth(image:UIImage, newSize: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

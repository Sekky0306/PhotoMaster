//
//  ViewController.swift
//  PhotoMaster
//
//  Created by Life is Tech on 2016/12/28.
//  Copyright © 2016年 Yuki Sekido. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    var ope: Int = 1
    
    @IBOutlet var photoImageView: UIImageView!
    
    func presentPickerController(sourceType: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        


    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        self.dismiss(animated: true, completion: nil)
        
        photoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTappedCameraButton(){
        presentPickerController(sourceType: .camera)
        
    }
    @IBAction func onTappedAlbumButton(){
        presentPickerController(sourceType: .photoLibrary)
    }
    @IBAction func onTappedTextButton(){
        ope = ope + 1
        print(ope)
        if photoImageView.image != nil{
            photoImageView.image = drawText(image: photoImageView.image!)
        }else{
            print("画像がありません")
        }
        
    }
    @IBAction func onTappedUploadButton(){
        if photoImageView.image != nil{
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!,"photoMaster"], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }else{
            print("画像がありません")
        }
        
    }
    @IBAction func onTappedIllustButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else{
            print("画像がありません")
        }
    }
    


    
    
    func drawText(image: UIImage) -> UIImage{
        let now = NSDate() // 現在日時の取得
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale! // ロケールの設定
        dateFormatter.dateFormat = "MM/dd" // 日付フォーマットの設定
        
//        print(dateFormatter.string(from: now as Date)) // -> 2014/06/25 02:13:18
        let text = dateFormatter.string(from: now as Date)
        
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0,y: 0, width: image.size.width, height: image.size.height))

        var textFontAttributes = [
            NSFontAttributeName: UIFont(name: "Arial",size: 120)!,
            NSForegroundColorAttributeName: UIColor.red]
        
        if ope%3 == 0{
            textFontAttributes = [
                NSFontAttributeName: UIFont(name: "Arial",size: 120)!,
                NSForegroundColorAttributeName: UIColor.blue]
            
        }else if ope%5 == 0{
            textFontAttributes = [
                NSFontAttributeName: UIFont(name: "Arial",size: 120)!,
                NSForegroundColorAttributeName: UIColor.green]
        }else{
            textFontAttributes = [
                NSFontAttributeName: UIFont(name: "Arial",size: 120)!,
                NSForegroundColorAttributeName: UIColor.red]
        }

        
        let margin: CGFloat = 5.0
        let textRect = CGRect(x: margin, y: margin, width: image.size.width - margin, height: image.size.height - margin)
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
       
        
        
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
        
    }
    func drawMaskImage(image: UIImage) -> UIImage{
        let maskImage = UIImage(named: "star2.png")!
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0,y: 0, width: image.size.width, height: image.size.height))
        let margin: CGFloat = 5.0
        let maskRect = CGRect(x: margin, y: margin, width: 1000, height: 1000)
        maskImage.draw(in: maskRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    
        
    }

   
    
   
}


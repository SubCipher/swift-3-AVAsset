//
//  ViewController.swift
//  MyAVAsset
//
//  Created by knax on 10/30/17.
//  Copyright © 2017 kpicart. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import AssetsLibrary
import Photos





class MyAVAsset: UIViewController {
    
    //create an AVAsset opt. property
    var myVideoAsset: AVAsset?
    
    @IBAction func loadAVAsset(_ sender: Any) {
        //check if authorization was granted by user
        PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
           
            if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
                //open imagePicker using delegate (pop over screen)
                 self.startImagePickerFromVC(self, usingDelegate: self)
            } else {
                
                let alert = UIAlertController(title: "Unauthorized", message: "Check access settings", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion:  nil)
            }
        })
        
    }

    
    func startImagePickerFromVC(_ viewController: UIViewController!, usingDelegate delegate: (UINavigationControllerDelegate & UIImagePickerControllerDelegate)!) {
        //check for source availability
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) == false {
            
            let alert = UIAlertController(title: "Source Not Available", message: "saved album not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            present(alert, animated: true, completion:  nil)
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.mediaTypes = [kUTTypeMovie as NSString as String]
        imagePicker.allowsEditing = true
        imagePicker.delegate = delegate
        present(imagePicker,animated: true, completion: nil)
        
    }
}

    

extension MyAVAsset: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        
        if mediaType == kUTTypeMovie {
            //initialize AVAsset
            let avAsset = AVAsset(url:info[UIImagePickerControllerMediaURL] as! URL)
            
            let message = "done"
            print("--------------------")
            print("avAsset",avAsset)
            print("--------------------")
            
            dismiss(animated: true, completion: nil)
            //use alert to info user process was completed
            let alert = UIAlertController(title: "Asset Loaded", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
             present(alert, animated: true, completion: nil)
        } else {
            //use alert to inform user process failed
            dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title: "Error", message: "assest not loaded", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
        
    }
}
extension MyAVAsset: UINavigationControllerDelegate {
    
}








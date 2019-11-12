//
//  SwiftClass.swift
//  NewReactProject
//
//  Created by haider ali on 30/10/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

import UIKit

@objc class SwiftClass:UIViewController {
  
  
  
//  
//  @objc func startNewApp() {
//    
//    
//    
//    self.resignFirstResponder()
//    
//    var vc = SwiftClass()
//    
//    vc.becomeFirstResponder()
//    
//    
//    
//     var window: UIWindow?
//
//       
//         
//         window = UIWindow(frame: UIScreen.main.bounds)
//
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//         let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginSignupVC")
//    
//    
//    
//
//         window?.rootViewController = initialViewController
//    window?.rootViewController = ViewController()
//         window?.makeKeyAndVisible()
//    
//    print("Its \(self.isFirstResponder)")
//    
//    print("starting new app")
//         
//    self.viewDidLoad()
//         
//   }
//  
//  
  

 @objc func someFunction(val:Any) {
  
  
  reStartApp()
  
  
  
  
  
  
  print("swift function called")

  }
 
  
  func reStartApp() {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginSignupVC")
    obj = UIApplication.shared.windows[0].rootViewController
    UIApplication.shared.windows[0].rootViewController = initialViewController
    
    
  }
//
//  func resetApp() {
//      UIApplication.shared.windows[0].rootViewController = UIStoryboard(
//          name: "Main",
//          bundle: nil
//          ).instantiateInitialViewController()
//  }

}

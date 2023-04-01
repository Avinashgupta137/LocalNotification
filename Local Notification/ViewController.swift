//
//  ViewController.swift
//  Local Notification
//
//  Created by IPS-108 on 29/03/23.
//

import UIKit
import Foundation
import UserNotifications

class ViewController: UIViewController {

    
    let nBody = "User Notification"
    let img = NSTextAttachment()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showNotification()
    }
    
    @IBAction func show(_ sender: Any) {
        showNotification()
    }
    func showNotification(){
        let noticenter = UNUserNotificationCenter.current()
        noticenter.requestAuthorization(options: [.alert,.sound]) { allowed, error in
            if allowed{
                print("Permission Granted")
            }
            else{
                print("Permission denied")
            }
        }
        
        img.image = UIImage(named: "doge.png")
        let imgStr = NSAttributedString(attachment: img)
        let myAttrStr = NSAttributedString(string: nBody, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40)])
        
        let attrStr = NSMutableAttributedString()
        attrStr.append(imgStr)
        attrStr.append(NSAttributedString(string: ""))
        attrStr.append(myAttrStr)
        
        
        
        let imageUrl = Bundle.main.url(forResource: "doge", withExtension: "png")!

        let attachment = try! UNNotificationAttachment(identifier: "doge", url: imageUrl, options: nil)
        
        let content = UNMutableNotificationContent()
        content.title = "Hello World"
        content.body = "lkb"
        //content.setValue(attrStr, forKey: "body")
        content.sound = .default
        content.attachments = [attachment]
        
        let identifier = "oop"
        
        let hour = 15
        let minute = 35
        
        let calender = Calendar.current
        var dateComponents = DateComponents(calendar: calender, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        noticenter.removeAllPendingNotificationRequests()
        noticenter.add(request)
    }


}


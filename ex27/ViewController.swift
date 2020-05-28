//
//  ViewController.swift
//  ex27
//
//  Created by Gor on 5/28/20.
//  Copyright © 2020 user1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var savedColors: [UIColor]? {
        get {
            if let colorDataArray = UserDefaults.standard.array(forKey: "savedColors") as? [Data] {
                return colorDataArray.map { UIColor.color(withData: $0)! }
            }
            return []
        }
        set {
            if let colorDataArray = newValue?.map({ $0.data() }) {
                UserDefaults.standard.set(colorDataArray, forKey: "savedColors")
            }

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        savedColors?.removeAll()
    }
    
    
    func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }


    @IBAction func buttonTapped(_ sender: Any) {
        var color: UIColor
        repeat {
            color = randomColor()
        } while savedColors!.contains(color)
        self.view.backgroundColor = color
        savedColors!.append(color)
    }
    
}

extension UIColor {
   func data() -> Data {
      return try! NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
   }
   class func color(withData data: Data) -> UIColor? {
      return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
   }
}

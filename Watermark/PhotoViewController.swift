//
//  PhotoViewController.swift
//  Watermark
//
//  Created by とむエナ on 2021/10/14.
//

import UIKit

class PhotoViewController: UIViewController {

    //変数設定
    var image1: UIImage!
    var image2: UIImage!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //機種判別
        let device = UIDevice.current
        print(device.modelName)
        
        //リサイズ
        image1 = UIImage.ResizeÜIImage(image: image1,width: self.view.frame.maxX, height: self.view.frame.maxY)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//機種番号から機種名に変換
private let DeviceList = [
    "iPhone9,1": "7", "iPhone9,3": "7", //7
    //"iPhone9,2": "7P", "iPhone9,4": "7P", //7 Plus
    "iPhone10,1": "8", "iPhone10,4": "8", //8
    //"iPhone10,2": "8P", "iPhone10,5": "8P" //8 Plus
    "iPhone10,3 ": "X", "iPhone10,6": "X", //X
    //"iPhone11,8": "XR", //XR
    "iPhone11,2": "XS", //XS
    //"iPhone11,4": "XSM", "iPhone11,6": "XSM", //XS Max
    "iPhone12,1": "11", //11
    "iPhone12,3": "11P", //11 Pro
    //"iPhone12,5": "11PM", //11 Pro Max
    //"iPhone12,8": "SE", //SE Gen2
    "iPhone13,1": "12M", //12 Mini
    "iPhone13,2": "12", //12
    "iPhone13,3": "12P", //12 Pro
    "iPhone13,4": "12PM", //12 Pro Max
    "iPhone14,4": "13M", //13 Mini
    "iPhone14,5": "13", //13
    "iPhone14,2": "13P", //13 Pro
    "iPhone14,3": "13PM" //13 Pro Max
]

extension UIDevice {
    //プラットフォームをだすクラスメソッド
    var platform: String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let mirror = Mirror(reflecting: systemInfo.machine)
        var identifier = ""

        for child in mirror.children {
            if let value = child.value as? Int8, value != 0 {
                identifier.append(UnicodeScalar(UInt8(bitPattern: value)).description)
            }
        }
        return identifier
    }

    //機種名をだすクラスメソッド
    var modelName: String {
        let identifier = platform
        return DeviceList[identifier] ?? identifier
    }
}

extension UIImage {
    //画像をResizeするクラスメソッド
    class func ResizeÜIImage(image : UIImage,width : CGFloat, height : CGFloat)-> UIImage!{
        // 指定された画像の大きさのコンテキストを用意.
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))

        // コンテキストに画像を描画する.
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))

        // コンテキストからUIImageを作る.
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // コンテキストを閉じる.
        UIGraphicsEndImageContext()
        
        return newImage
    }

    //画像を合成するクラスメソッド
    class func ComposeUIImage(UIImageArray : [UIImage], width: CGFloat, height : CGFloat)->UIImage!{
        // 指定された画像の大きさのコンテキストを用意.
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        
        // UIImageのある分回す.
        for image : UIImage in UIImageArray {
            // コンテキストに画像を描画する.
            image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        }
        // コンテキストからUIImageを作る.
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // コンテキストを閉じる.
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

//
//  PhotoViewController.swift
//  Watermark
//
//  Created by とむエナ on 2021/10/14.
//

import UIKit

class PhotoViewController: UIViewController {

    // 変数設定
    var BackImage: UIImage!
    var Watermark: UIImage!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 機種判別
        let device = UIDevice.current.modelName
        
        // Google DriveのIDを検索
        var ID:String!
        if device == "7" {
            ID = "1GeBA36TvonNPfWyjuQ23vJIvjeg6lLlX"
        } else if device == "8" {
            ID = "1DcS_-VrufHxJGUCbQ-Wv6Weq73Mku4V2"
        } else if device == "X" {
            ID = "1FIu23l1DDENwK2BEYSo1nCtUD92OVDij"
        } else if device == "XS" {
            ID = "1PatV2em2As4AVupS9QB1eDpJ11rFLFYc"
        } else if device == "11" {
            ID = "1JDPDRuaTv7tPf17Jl4aDKlyZJcCWMFqG"
        } else if device == "11Pro" {
            ID = "1-E4e2r8iXljW0r-cIItfznV403Id-fPD"
        } else if device == "12Mini" {
            ID = "1JACwCU6P70iq7Zoohk67wxLVAIDrWpjt"
        } else if device == "12" {
            ID = "1J8zTL4w8bqYzXqqa_oz-7oi71AJOVPH8"
        } else if device == "12Pro" {
            ID = "17TFmB-CJZZiBA3ANgxS72G4Js_JMHomm"
        } else if device == "13Mini" {
            ID = "16-gN2PpMyJVtT8zqkEjr6nBbtIZXaXvp"
        } else if device == "13" {
            ID = "16GLfHNSC5Fni1xW00DzhhXbwl3SnMW7C"
        } else if device == "13Pro" {
            ID = "16CUUtHhi3Ok2R0zRQyDGgoiAy6KiYkIW"
        } else if device == "13ProMax" {
            ID = "165biqyy_QwA4lKC5yJQTrKV2e8Dzz21D"
        } else {
            print("あなたの" + device + "はまだウォーターマークがありません\n恐れ入りますが、お問い合わせしてください")
        }
        
        // 画像1をリサイズ
        BackImage = UIImage.ResizeÜIImage(image: BackImage,width: imageView.bounds.width, height: imageView.bounds.height)
        
        // URLを作成
        let URL:String = "https://drive.google.com/uc?id=" + ID
        
        // 写真2をセット
        Watermark = UIImage(url: URL)
        
        // 画像2をリサイズする.
        Watermark = UIImage.ResizeÜIImage(image: Watermark,width: BackImage.size.width / 10, height: BackImage.size.height / 10)
        
        // 画像を合成する.
        let ComposedImage = UIImage.ComposeUIImage(UIImageArray: [BackImage, Watermark], width: self.view.frame.maxX, height: self.view.frame.maxY)

        //写真を表示する
        imageView.image = ComposedImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//機種番号から機種名に変換
private let DeviceList = [
    "iPhone9,1": "7", "iPhone9,3": "7", //7
    //"iPhone9,2": "7Plus", "iPhone9,4": "7Plus", //7 Plus
    "iPhone10,1": "8", "iPhone10,4": "8", //8
    //"iPhone10,2": "8Plus", "iPhone10,5": "8Plus" //8 Plus
    "iPhone10,3 ": "X", "iPhone10,6": "X", //X
    //"iPhone11,8": "XR", //XR
    "iPhone11,2": "XS", //XS
    //"iPhone11,4": "XSMax", "iPhone11,6": "XSMax", //XS Max
    "iPhone12,1": "11", //11
    "iPhone12,3": "11Pro", //11 Pro
    //"iPhone12,5": "11ProMax", //11 Pro Max
    //"iPhone12,8": "SE2", //SE Gen2
    "iPhone13,1": "12Mini", //12 Mini
    "iPhone13,2": "12", //12
    "iPhone13,3": "12Pro", //12 Pro
    //"iPhone13,4": "12ProMax", //12 Pro Max
    "iPhone14,4": "13Mini", //13 Mini
    "iPhone14,5": "13", //13
    "iPhone14,2": "13Pro", //13 Pro
    "iPhone14,3": "13ProMax" //13 Pro Max
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
    
    //URLから画像を持ってくる
    public convenience init(url: String) {
            let url = URL(string: url)
            do {
                let data = try Data(contentsOf: url!)
                self.init(data: data)!
                return
            } catch let err {
                print("Error : \(err.localizedDescription)")
            }
            self.init()
        }
}

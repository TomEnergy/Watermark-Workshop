//
//  PhotoViewController.swift
//  Watermark
//
//  Created by とむエナ on 2021/10/14.
//

import UIKit

class PhotoViewController: UIViewController {

    var image: UIImage?

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

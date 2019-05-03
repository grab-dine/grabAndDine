//
//  LoadViewController.swift
//  GrabAndDine
//
//  Created by Rachel Chen on 4/12/19.
//  Copyright © 2019 rachelchen0418. All rights reserved.
//

import UIKit
import FLAnimatedImage

class LoadViewController: UIViewController {

    @IBOutlet weak var gif: FLAnimatedImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let path1 : String = Bundle.main.path(forResource: "load", ofType: "gif")!
//        let imageData1 = try? FLAnimatedImage(animatedGIFData: Data(contentsOf: URL(fileURLWithPath: path1)))
//        gif.animatedImage = imageData1 as! FLAnimatedImage      // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

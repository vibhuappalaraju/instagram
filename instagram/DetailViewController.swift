//
//  DetailViewController.swift
//  instagram
//
//  Created by Vibhu Appalaraju on 10/3/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: ViewController {
    
    
    var post : Post?
    @IBOutlet weak var timestapLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    
    @IBOutlet weak var largeInstaImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let post = post{
          let bigImage = post.media as PFFile
          bigImage.getDataInBackground{ (imageData: Data?, error: Error?) in
                if (error == nil) {
                    if let imageData = imageData {
                        let image = UIImage(data: imageData)
                        self.largeInstaImage.image = image
                    }
                }
            }
            numLikesLabel.text = "Likes: " + String(post.likesCount)
            captionLabel.text = "Caption: " + String(post.caption)
            timestapLabel.text = post.date
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

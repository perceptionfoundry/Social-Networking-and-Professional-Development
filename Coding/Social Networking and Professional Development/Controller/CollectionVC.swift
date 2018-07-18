//
//  CollectionVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 18/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CollectionVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePagerBar()


        // Do any additional setup after loading the view.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let All = storyBoard.instantiateViewController(withIdentifier: "All_Courses")
        let Purchase = storyBoard.instantiateViewController(withIdentifier: "Purchase_Courses")
       
        return [All, Purchase]
    }
    
    func configurePagerBar(){
        settings.style.buttonBarItemBackgroundColor = UIColor(hexColor: "BD576C")
        settings.style.selectedBarBackgroundColor = UIColor.black
        settings.style.selectedBarHeight = 0.3
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 16)
        
    }
    
//    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 100.0, height: collectionView.frame.height)
//
//    }




}

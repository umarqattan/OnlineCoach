//
//  CreateUserPageViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class CreateUserPageViewController: UIPageViewController,UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    
    public var identifiers = ["UserInformationViewController", "BodyInformationViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        setupPageControl()
        
        
        
        setViewControllers([viewControllerAtIndex(index: 0)!], direction: .forward, animated: true, completion: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private func setupPageControl() {
        
      
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.darkGray
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        
        if identifiers.count == 0 || index >= identifiers.count {
            return nil
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
    
        let viewController = storyBoard.instantiateViewController(withIdentifier: identifiers[index])
        
        
        
        return viewController
    }
    
   
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc1 = viewControllerAtIndex(index: 0) as? UserInformationViewController
        let vc2 = viewControllerAtIndex(index: 1) as? BodyInformationViewController
        var index:Int = 0
        
        if viewController == vc1 {
            
            index = (vc1?.index)!
        } else if viewController == vc2 {
            index = (vc2?.index)!
        } else {
            return nil
        }
    
        index += 1
        
        if index == identifiers.count {
            return nil
        }
        
        return viewControllerAtIndex(index: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc1 = viewControllerAtIndex(index: 0) as? UserInformationViewController
        let vc2 = viewControllerAtIndex(index: 1) as? BodyInformationViewController
        var index:Int = 0
        
        if viewController == vc1 {
            index = (vc1?.index)!
        } else if viewController == vc2 {
            index = (vc2?.index)!
        } else {
            return nil
        }

        
        if index == 0 || index == NSNotFound {
            return nil
        }
    
        index -= 1
        
        return viewControllerAtIndex(index: index)

    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return identifiers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

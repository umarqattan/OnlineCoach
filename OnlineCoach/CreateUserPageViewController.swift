//
//  CreateUserPageViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class CreateUserPageViewController: UIPageViewController,UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    
    public var identifiers = ["UserInformationViewController", "BodyInformationViewController", "GoalsInformationViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        setupPageControl()
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewControllers([viewControllerAtIndex(index: 0)!], direction: .forward, animated: true, completion: nil)
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
        appearance.backgroundColor = UIColor(colorLiteralRed: 0.0/255.0, green: 128.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        
        if identifiers.count == 0 || index >= identifiers.count {
            return nil
        }
       
        
    
        let viewController = storyboard?.instantiateViewController(withIdentifier: identifiers[index])
        
        
        
        return viewController
    }
    
   
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc1 = viewControllerAtIndex(index: 0) as? UserInformationViewController
        let vc2 = viewControllerAtIndex(index: 1) as? BodyInformationViewController
        let vc3 = viewControllerAtIndex(index: 2) as? GoalsInformationViewController
        
        var index:Int = 0
        
        
        
        if viewController.isKind(of: UserInformationViewController.self) {
            index = (vc1?.index)!
            
        } else if viewController.isKind(of: BodyInformationViewController.self) {
            index = (vc2?.index)!
        } else if viewController.isKind(of: GoalsInformationViewController.self) {
                index = (vc3?.index)!
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
        let vc3 = viewControllerAtIndex(index: 2) as? GoalsInformationViewController
        var index:Int = 0
        
        
        if viewController.isKind(of: UserInformationViewController.self) {
            index = (vc1?.index)!
            
        } else if viewController.isKind(of: BodyInformationViewController.self) {
            index = (vc2?.index)!
        } else if viewController.isKind(of: GoalsInformationViewController.self) {
            index = (vc3?.index)!
        } else {
            return nil
        }

        
        if index == 0 || index == NSNotFound {
            return nil
        }
    
        index -= 1
        
        return viewControllerAtIndex(index: index)
        
     

    }
    
    
        
}

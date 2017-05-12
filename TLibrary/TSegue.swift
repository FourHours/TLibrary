//
//  TSequeBuilder.swift
//  AwesomePosts
//
//  Created by Q Zhuang on 5/7/17.
//  Copyright © 2017 Q Zhuang. All rights reserved.
//

import Foundation
import UIKit

/*
 guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewControllerWithIdentifier("identifier") as? SecondViewController else {
 print("Could not instantiate view controller with identifier of type SecondViewController")
 return
 }

 vc.resultsArray = self.resultsArray
 self.navigationController?.pushViewController(vc, animated:true)
 */

/*
 override func prepare(for segue: UIStoryboardSegue, sender: Any?)
 */

public class TSegue {
    var destViewController: String
    var source: UIViewController
    var props: Dictionary<String, Any>
    var storyboardName = "Main"

    public init(source: UIViewController, dest: String, props: Dictionary<String, Any>) {
        destViewController = dest
        self.props = props
        self.source = source
    }

    public func storyboardName(_ name: String) -> Self {
        storyboardName = name
        return self
    }

    public func push() {
        guard let vc = UIStoryboard(name: self.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "identifier") as? TPropertyDatasource
        else {
            print("Could not instantiate view controller with identifier of type SecondViewController")
            return
        }
        vc.props = props
        source.navigationController?.pushViewController(vc as! UIViewController, animated: true)
    }

    public func present() {
        guard let vc = UIStoryboard(name: self.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "identifier") as? TPropertyDatasource
        else {
            print("Could not instantiate view controller with identifier of type SecondViewController")
            return
        }
        vc.props = props

        source.present(vc as! UIViewController, animated: true, completion: nil)
    }

    public func perform() {
    }
}

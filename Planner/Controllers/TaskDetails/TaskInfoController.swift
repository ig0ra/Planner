//
//  TaskInfoController.swift
//  Planner
//
//  Created by Igor O on 20.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class TaskInfoController: UIViewController {
    @IBOutlet weak var textviewTaskInfo: UITextView!
    
    var taskInfo:String!
    
    var delegate:ActionResultDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Description"
        
        textviewTaskInfo.becomeFirstResponder()

        textviewTaskInfo.text = taskInfo  
    }
    
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        delegate?.done(source: self, data: textviewTaskInfo.text)
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

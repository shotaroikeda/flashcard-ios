//
//  flashcardTableViewController.swift
//  flashcard-ios
//
//  Created by Shotaro Ikeda on 2/27/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import UIKit
import Firebase

class flashcardTableViewController: UITableViewController {

    /* Fake data here. Delete when the real data comes in through firebase */
    var userData : FlashCardData = FlashCardData()
    
    func populateFakeData () {
        self.userData.classNames = ["CS 125", "CS 241"]
        self.userData.flashCards = ["CS 125" :
            /* Questions for CS 125 here... */
            [
                /* Question 1 */
                Question(question: "What are the four properties of Object-Orientated Programming?",
                    answer: "Inheritance, Polymorphism, Abstraction, and Encapsulation", weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 2 */
                Question(question: "What does MVC stand for?",
                    answer: "Model, View, Controller.", weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 3 */
                Question(question: "Big-O Running time of BubbleSort?",
                    answer: "O(n)", weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 4 */
                Question(question: "Describe the QuickSort Algorithmn's running times",
                    answer: "Quicksort is generally O(nlogn). However it relies heavily on picking a correct 'pivot' value",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 5 */
                Question(question: "Describe the strengths of recursion.",
                    answer: "Ability to write complex code a lot simpler, Specific optimizations using recursion, and abstraction of ideas",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 6 */
                Question(question: "How do you commit to SVN?",
                    answer: "svn ci -m 'commit msg'", weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 7 */
                Question(question: "How do you make a 2D array in Java?",
                    answer: "int arr[num1][num2];",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 8 */
                Question(question: "What is the key word associated with inheritance?",
                    answer: "extends",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 9 */
                Question(question: "What does implements do?",
                    answer: "Implements from a interface class.",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Qusetion 10 */
                Question(question: "What are Java's primatives?",
                    answer: "int, long, char, float, and double",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0)
            ],
            "CS 241" :
            /* Questions for CS 225 here... */
            [
                /* Question 1 */
                Question(question: "How large is a pointer?",
                    answer: "8 bytes on 64 bit machines, 4 bytes on 32 bit machines",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 2 */
                Question(question: "What's special about sizeof(char)?",
                    answer: "Always 1 byte",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 3 */
                Question(question: "How large is 1 byte (bits)?",
                    answer: "usually 8 bits, depends on architecture",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 4 */
                Question(question: "How do I create threads?",
                    answer: "pthread_create()",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 5 */
                Question(question: "What is a race condition?",
                    answer: "When two different threads attempt to access the same portion of memory, such that it occurs unintended behavior",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 6 */
                Question(question: "What are mutexes?",
                    answer: "Ways to block access to data structures, as a resolution to most race conditions",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 7 */
                Question(question: "What is the GNU Linux call to manually expand heap memory?",
                    answer: "sbrk()",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0),
                /* Question 8 */
                Question(question: "What is special about the last program argument?",
                    answer: "Always points to NULL.",
                    weight: 1.0, tries_attempted: 0, total_attempted: 0)
            ]
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Populate the tables with fake data...
        populateFakeData()
        // Remove when done testing
        
        self.navigationController!.navigationBar.topItem!.title = "Classes"
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userData.classNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("classTitle", forIndexPath: indexPath) as! flashcardTableViewCell
        cell.classLabel!.text = userData.classNames[indexPath.row]

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedIndex = self.tableView.indexPathForCell(sender as! flashcardTableViewCell)
        if segue.identifier == "toCardView" {
            if let flashView = segue.destinationViewController as? flashcardDetailViewController {
                flashView.classTitle = userData.classNames[selectedIndex!.row]
                flashView.questions = userData.flashCards[userData.classNames[selectedIndex!.row]]
            } else {
                print(sender)
            }
        }
    }

}

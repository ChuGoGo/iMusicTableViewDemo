//
//  FristViewController.swift
//  TableViewDemo
//
//  Created by Chu Go-Go on 2022/4/26.
//

import UIKit

class FristViewController: UIViewController {
    @IBOutlet weak var singerTextField: UITextField!
//    儲存抓到的歌手
    var singers = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func searchButton(_ sender: Any) {
        singerTextField.text = ""

    }
//    按下收尋後
    @IBSegueAction func singerName(_ coder: NSCoder) -> DemoTableViewController? {
        if let singer = singerTextField.text{
//            把收尋的歌手夾到api的網址裡，並且如果是中文的會轉型成代碼
            singers =  "https://itunes.apple.com/search?term=\(singer)&media=music".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            傳到下一頁
            return DemoTableViewController(coder: coder, singer: singers)
        } else {
            return nil
        }
    }
    @IBAction func unwindToFrist(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        
        // Use data from the view controller which initiated the unwind segue
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

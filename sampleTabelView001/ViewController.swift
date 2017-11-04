//
//  ViewController.swift
//  sampleTabelView001
//
//  Created by 濱野将士 on 2017/10/30.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    var selectedIndex = -1
    //データを配列で用意する
    var tea_list = ["ダージリン","アールグレイ","アッサム","オレンジペコ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
 
    override func viewWillAppear(_ animated: Bool) {
        //-- json.txtファイルを読み込んで
        let path = Bundle.main.path(forResource: "json", ofType: "txt")
        let jsondata = try? Data(contentsOf: URL(fileURLWithPath: path!))
        //-- 辞書データに変換して
        let jsonArray = (try! JSONSerialization.jsonObject(with: jsondata!, options: [])) as! NSArray
        //--  辞書データの個数だけ繰り返して表示する
        for data in jsonArray {
            var dicForData:NSDictionary = data as! NSDictionary
            
            print("[\(dicForData["name"])]")
            tea_list.append(data as! NSDictionary)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tea_list.count
    }
    
    // 表示するセルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        //cell.textLabel!.text = "\(indexPath.row)行目"
        
        //文字色を茶色にする
        cell.textLabel?.textColor = UIColor.brown
        //矢印を右側につける
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel!.text = "\(tea_list[(indexPath as NSIndexPath).row])"
        return cell
        
    }
    
    // 選択された時に行う処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\((indexPath as NSIndexPath).row)行目を選択")
        selectedIndex = (indexPath as NSIndexPath).row
        performSegue(withIdentifier: "showSecondView",sender: nil)
    }
    
    // Segueで画面遷移する時
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DetailVC = segue.destination as! DetailViewController
        
       DetailVC.scSelectedIndex = selectedIndex
        
        //            if (segue.identifier == "showSecondView") {
        //                let secondVC: secondViewController = (segue.destinationViewController as? secondViewController)!
        //
        //                // SecondViewControllerのtextに選択した文字列を設定する
        //                // secondVC.text = selectedText
        //            }
    }
}

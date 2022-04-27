//
//  DemoTableViewController.swift
//  TableViewDemo
//
//  Created by Chu Go-Go on 2022/4/20.
//

import UIKit
import Kingfisher
class DemoTableViewController: UITableViewController{
    //    裝著網路資料的struct
    var songInfo: [song] = [song]()
    //    是誰的歌
    var singer = ""
    //    收尋歌時會用到
    lazy var filteredSongs = songInfo
    //    從第一頁傳送的資料
    required init?(coder: NSCoder,singer: String) {
        super.init(coder: coder)
        self.singer = singer
    }
    //    如果資料沒有值會顯示Error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    當程式啟動時
    override func viewDidLoad() {
        //        print("singer\(singer)")
        super.viewDidLoad()
        //        建立一個SearchBar
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        //        捲動時讓SearchBar消失
        navigationItem.hidesSearchBarWhenScrolling = true
        //        跑出下載好的資料
        updatData()
    }
    
    // MARK: - Table view data source
    //Sections的數量就是filteredSong有的數量
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //        收尋時結果的數量
        return filteredSongs.count
    }
    //有幾筆的數量就是filteredSong有的數量
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //        收尋時結果的數量
        return filteredSongs.count
    }
    
    //  TableViewCell顯示的東西
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SongTableViewCell.self)", for: indexPath) as! SongTableViewCell //轉型成TableViewCell
        //        點選的歌是哪首
        let song = filteredSongs[indexPath.row]
        //        顯示圖片
        cell.songImage?.kf.setImage(with: song.artworkUrl100)
        //        歌名
        cell.songTitleLabel.text = song.trackName
        //        歌手
        cell.artiesLabel.text = song.artistName
        //        專輯名稱
        cell.timeLabel.text = song.collectionName
        //         第幾手
        cell.trackLabel.text = "Tarck \(song.trackCount)"
        //  回傳到Cell
        return cell
    }
//    選擇好的音樂傳到下一頁
    @IBSegueAction func playSong(_ coder: NSCoder) -> ViewController? {
//        row會是選擇好的那一個
        if let row = tableView.indexPathForSelectedRow?.row{
//            傳到下一頁，看是哪首歌，以及抓到的所有資料，還有是資料的第幾筆
            return ViewController(coder: coder, songs: filteredSongs[row], songlist: filteredSongs ,musicIndex: row)
        }else{
//            沒抓到的話回傳nil
            return nil
        }
    }
    
//  下載資料
    func updatData(){
//        建立一個url裝著找到的資料
        if let url = URL(string:singer) {
//            從url載入data
            URLSession.shared.dataTask(with: url) { data, response, error in
//                如果有error就會跑到然後跳出
                if let error = error {
                    print("error\(error)")
                    return
                }
//                載入回傳值==200就是成功找到資料，沒找到跳出func
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else{
                    return
                }
//                得到的資料
                if let data = data {
//                  使用JSONDecoder()來解碼
                    let decoder = JSONDecoder()
//                    解碼器是.iso8601
                    decoder.dateDecodingStrategy = .iso8601
//                    抓資料
                    do {
//                        嘗試看看是否抓到資料
                        let searchResponse = try
                        decoder.decode(SearchResponse.self, from: data)
//                        收尋抓到的資料儲存在filteredSongs
                        self.filteredSongs = searchResponse.results
//                        還有全部歌曲songInfo
                        self.songInfo = searchResponse.results
//                        讓這段程式碼優先執行
                        DispatchQueue.main.async {
//                            更新畫面
                            self.tableView.reloadData()
//                            如果抓不到資料跳出alert訊息
                            if self.filteredSongs.count == 0{
                                let alert = UIAlertController(title: "找不到此歌手", message: "請確認名稱是否正確！", preferredStyle: .alert)
                                //                                按下ok後回到上一頁
                                let ok = UIAlertAction(title: "確定", style: .default){_ in
                                    self.navigationController?.popToRootViewController(animated: true)
                                }
                                alert.addAction(ok)
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    } catch{
                        print(error)
                    }
                } else{
                    //                    print(error)
                }
//                執行Func
            }.resume()
            
        }
        
    }
    
}
//extension一個UISearchResultsUpdating 來找到收尋的資料
extension DemoTableViewController: UISearchResultsUpdating {
//    收尋的func
    func updateSearchResults(for searchController: UISearchController) {
//        找的=你打的字
        if let searchText = searchController.searchBar.text,
//           如果searchText不是空的
           searchText.isEmpty == false{
//            把找到的抓到filter裡
            filteredSongs = songInfo.filter({ song in
//                字有一樣的才會被找到
                song.trackName.localizedStandardContains(searchText)
            })
//            沒找到就是全部得資料
        }else{
            filteredSongs = songInfo
        }
//        更新tableView
        tableView.reloadData()
    }
}

//
//  songlist.swift
//  TableViewDemo
//
//  Created by Chu Go-Go on 2022/4/22.
//

import Foundation
import UIKit
//Codable下載解碼資料
struct SearchResponse: Codable{
//    下載了幾筆
    let resultCount: Int
//    儲存下載的結果
    let results: [song]
}
//需要用到的資料
struct song: Codable{
//    歌手名字
    let artistName: String
//    音樂名字
    let trackName: String
//    專輯名字
    let collectionName: String?
//    歌曲的網址
    let previewUrl: URL
//    專輯圖片
    let artworkUrl100: URL
//    一首個的價錢
    let trackPrice: Double?
//  專輯裡的第幾首
    let trackCount: Int
//    到時候點唱機顯示的圖片大小
    var artworkUrl500: URL{
        artworkUrl100.deletingLastPathComponent().appendingPathComponent("240x240bb.jpg")
    }
    //    let releaseDate: Date
    //    let isStreamable: Bool?
}

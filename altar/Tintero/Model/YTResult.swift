//
//  YTResult.swift
//  altar
//
//  Created by Juan Moreno on 1/16/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation


struct PageInfo: Decodable {
    var totalResults = 0
    var resultsPerPage = 0
}


struct Snippet: Decodable {
    var channelId = ""
    var title = ""
    var description = ""
    var channelTitle = ""
    var thumbnails: Thumbnail
}


struct ChannelURL: Decodable {
    var url = ""
}

struct Thumbnail: Decodable {
    var medium: ChannelURL
    var high: ChannelURL
}

struct ids: Decodable {

   //   var kind  = ""
      var videoId = ""
     // var channelId = ""
    //  var playlistId = ""
    
}

struct Item: Decodable {
    var kind = ""
    var etag = ""
    var snippet: Snippet
    var id: ids

}




struct YTResult: Decodable {
    var kind = ""
    var etag = ""
    var pageInfo: PageInfo
    var items: [Item]
    var nextPageToken = ""
}

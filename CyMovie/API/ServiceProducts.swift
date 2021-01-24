//
//  ServiceProducts.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import Foundation

class  ServiceProducts {
    #if DEBUG
    private static let BASE_URL: String = "https://api.themoviedb.org/3"
    #else
    private static let BASE_URL: String = "https://api.themoviedb.org/3"
    #endif
    private static let apiClient = AFApiClient()
    
    let apikey = "a4b9f19e7521b0b207c5f235c4540d64"
    //genre/movie/list?api_key=<<api_key>>&language=en-US
    //MARK: - CallBacks
    typealias callBackGetVideo = ([ModelVideo]) -> Void
    typealias callBackGetProduct = ([ModelMovie]) -> Void
    typealias callBackGetGenre = ([ModelGenre]) -> Void
    typealias callBackError = (Error) -> Void
    
    static func getMovieList(page: Int, genreId: Int = 28, onsuccess callbackSuccess: @escaping callBackGetProduct, onError: @escaping callBackError) {
        let strUrl: String = "\(BASE_URL)/movie/top_rated"
        
       //https://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>&language=en-US&page=1
        var params: [String : Any] = [:]
        params["api_key"] =  "a4b9f19e7521b0b207c5f235c4540d64"
        params["language"] = "en-US"
        params["page"] = page
        params["with_genres"] = genreId
        var arrProduct: [ModelMovie] = [ModelMovie]()
        self.apiClient.request(param: params, httpMethod: .get, strUrl: strUrl) { (result) in
            let (jsonData,error) = result
            print("jsonData",result)
            if let _jsonData = jsonData {
                for data in _jsonData["results"].arrayValue {
                    arrProduct.append(ModelMovie(jsonData: data))
                    debugPrint("ITEM", data)
                }
                callbackSuccess(arrProduct)
            }else {
                onError(error!)
            }
        }
    }
    
    static func getGenre(sortBy filter: Filter, onsuccess callbackSuccess: @escaping callBackGetGenre, onError: @escaping callBackError ) {
        
        let strUrl: String = "\(BASE_URL)/genre/movie/list"
        
        var arrGenre: [ModelGenre] = [ModelGenre]()
        var params: [String : Any] = [:]
        params["api_key"] =  "a4b9f19e7521b0b207c5f235c4540d64"
        params["language"] = "en-US"

        self.apiClient.request(param: params, httpMethod: .get, strUrl: strUrl) { (result) in
            let (jsonData,error) = result
            print("jsonData",result)
            if let _jsonData = jsonData {
                for data in _jsonData["genres"].arrayValue {
                    arrGenre.append(ModelGenre(jsonData: data))
                    //debugPrint("ITEM", data)
                }
                callbackSuccess(arrGenre)
            }else {
                onError(error!)
            }
        }
    }
    
    //https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key=<<api_key>>&language=en-US
    
    static func getVideos(id movieID: String, onsuccess callbackSuccess: @escaping callBackGetVideo, onError: @escaping callBackError ) {
        
        let strUrl: String = "\(BASE_URL)/movie/\(movieID)/videos"
        
        var arr: [ModelVideo] = [ModelVideo]()
        var params: [String : Any] = [:]
        params["api_key"] =  "a4b9f19e7521b0b207c5f235c4540d64"
        params["language"] = "en-US"

        self.apiClient.request(param: params, httpMethod: .get, strUrl: strUrl) { (result) in
            let (jsonData,error) = result
            print("jsonData",result)
            if let _jsonData = jsonData {
                for data in _jsonData["results"].arrayValue {
                    arr.append(ModelVideo(jsonData: data))
                    debugPrint("ITEM", data)
                }
                callbackSuccess(arr)
            }else {
                onError(error!)
            }
        }
    }
}

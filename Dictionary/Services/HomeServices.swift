//
// Created by Rocky on 2017/5/25.
// Copyright (c) 2017 Rocky. All rights reserved.
//

import Foundation
import RxSwift
import AVFoundation


class HomeServices:BaseService{
    
    var player:AVPlayer?
    

    func requestData(string:String) -> Observable<WordModel> {
        
        return dictionaryAPI.request(.query(target: string))
            .asObservable()
            .mapJSON()
            .mapToObjectWithNoError(modelType: WordModel.self)
        
    }
    
    
    func playAudio(urlString:String) -> Observable<Void> {
        
        print(urlString)
        
        if let url = URL(string: urlString){
            
            player = AVPlayer(url: url)
            
            player?.play()
        }
        
       
        return Observable.empty()
    }
    
    @discardableResult
    func storageNewWord(item:WordModel) -> Observable<WordModel> {
        
        let data = configureData(data: item,needNewId: true)
        
        if data.translation.toArray().count > 0 {
            
            return databaseService.createAndUpdateItem(item: data)
                .mapWordDataModelToWordModel()
            
        }
        
        
        return Observable.empty()
    }
    
    func allHistory() -> Observable<[WordModel]>{
        
        return databaseService.items()
            .map { return $0.toArray() }
            .mapDataModelArrayToWordModelArray()
    }
    
    func update(item:WordModel) -> Observable<Void>{
        
        let dataModel = configureData(data: item)
        
        _ = databaseService.createAndUpdateItem(item: dataModel)
                .mapWordDataModelToWordModel()
                .subscribe{
                    print($0)
                }
        
        return Observable.empty()
    }
    
}



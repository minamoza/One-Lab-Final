//
//  TopicViewModel.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 04.05.2022.
//

import Foundation

class TopicViewModel{
    private let topicService: GetTopicService
    var isRequestPerforming = false
    var didLoadPhoto: (([Topic]) -> Void)?
    
    init(topicService: GetTopicService){
        self.topicService = topicService
    }
    

    
    func getTopic(){
        isRequestPerforming = true
        
        topicService.getTopic(
            success: { [weak self] category in
//            print(category)
                self?.didLoadPhoto?(category)
            }, failure: { error in
                print(error)
            })
    }

    
}


//
//  TopicViewModel.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 04.05.2022.
//

import Foundation

class TopicViewModel{
    private let topicService: GetTopicService
    
    var didLoadPhoto: (([Topic]) -> Void)?
    
    init(topicService: GetTopicService){
        self.topicService = topicService
    }
    
    func getTopic(){
        topicService.getTopic {
            [weak self] category in
            DispatchQueue.main.async{
            print(category)
            }
        } failure: { error in
            print(error)
        }

    }
}

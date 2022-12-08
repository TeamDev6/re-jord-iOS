//
//  FlowStep.swift
//  ReJordIOS
//
//  Created by 송하민 on 2022/12/08.
//  Copyright © 2022 reJordiOS. All rights reserved.
//

import RxFlow

enum FlowSteps: Step {
    
    case mainSearchIsRequired
    
    case detailRepositoryInformationIsRequired(repoName: String, ownerName: String)
}

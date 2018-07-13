//
//  BadgeSelectorViewModel.swift
//  RxExample
//
//  Created by 山浦功 on 2018/07/13.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BadgeSelectorViewModel {
    typealias Dependency = (
        repository: AnyEntityRepository<Void, [Badge], Never>,
        wireframe: BadgeSelectorWireframe
    )
    
    typealias Input = (
        doneTap: RxCocoa.Signal<Void>,
        selector: RxCocoa.Signal<Badge>,
        selectableTap: RxCocoa.Signal<Badge>
    )
    
    let selectedViewModel: SelectedBadgesViewModel
    let selectableViewModel: Selectable
}

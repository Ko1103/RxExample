//
//  BadgeSelectorCompleionViewModel.swift
//  RxExample
//
//  Created by 山浦功 on 2018/07/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

//DoneButtonに対応するViewModel
class BadgeSelectorCompletionViewModel {
    
    typealias Dependency = (
        selectedBadgesRelay: RxCocoa.BehaviorRelay<[Badge]>,
        wireframe: BadgeSelectorWireframe
    )
    
    let canComplete: RxCocoa.Driver<Bool>.E
    
    private let dependency: Dependency
    private let disposeBag = DisposeBag()
    
    init(input doneTap: RxCocoa.Signal<Void>, dependency: Dependency) {
        self.dependency = dependency
        
        //バッジが一つも選択されていなければ
        //UINavigationBar上のDoneButtonを無効にする
        self.canComplete = dependency.selectedBadgesRelay
            .map{ selection in !selection.isEmpty }
            .asDriver(onErrorDriveWith: SharedSequence<DriverSharingStrategy, Bool>.empty())
        
        doneTap.emit(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            let url = "httos"
            self.dependency.wireframe.open(url: URL(string: url)!)
        }, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
}

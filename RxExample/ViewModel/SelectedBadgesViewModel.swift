//
//  SelectedBadgeViewModel.swift
//  RxExample
//
//  Created by 山浦功 on 2018/07/08.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SelectedBadgesViewModel {
    
    //Viewへの出力　上部に表示するバッジ一覧のDriver
    let selectedBadge: RxCocoa.Driver<[Badge]>
    //Viewへの出力　選択解除されたバッジを通知する
    let badgeDidDeselect: RxCocoa.Signal<Badge>
    
    private let selectedBadgesRelay: RxCocoa.BehaviorRelay<[Badge]>
    private let badgeDidDeselectRelay: RxCocoa.PublishRelay<Badge>
    
    private let disposeBag = RxSwift.DisposeBag()
    
    init(
        //上部バッジのタップイベントのSignal
        input selectedTap: RxCocoa.Signal<Badge>,
        //選択されたBadgeの一覧を保持したBehaviorReplay
        dependency selectedBadgesRelay: RxCocoa.BehaviorRelay<[Badge]>
        ){
        //選択済みのバッジの出力
        self.selectedBadgesRelay = selectedBadgesRelay
        self.selectedBadge = selectedBadgesRelay.asDriver()
        
        let badgeDidDeselectRelay = RxCocoa.PublishRelay<Badge>()
        self.badgeDidDeselectRelay = badgeDidDeselectRelay
        self.badgeDidDeselect = badgeDidDeselectRelay.asSignal()
        
        //上部バッジタップで選択を解除する。
        selectedTap.emit(onNext: { [weak self] badge in
            guard let `self` = self, let index = self.selectedBadgesRelay.value.index(of: badge) else { return }
            var newSelectedBadges = self.selectedBadgesRelay.value
            newSelectedBadges.remove(at: index)
            self.selectedBadgesRelay.accept(newSelectedBadges)
            
            self.badgeDidDeselectRelay.accept(badge)
        }, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
}

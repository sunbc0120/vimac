//
//  HintModeInputListener.swift
//  Vimac
//
//  Created by Dexter Leng on 23/8/20.
//  Copyright © 2020 Dexter Leng. All rights reserved.
//

import Cocoa
import RxSwift

class HintModeInputListener {
    private let disposeBag = DisposeBag()
    private let inputListener = InputListener()
    
    func observeEscapeKey(onEvent: @escaping (NSEvent) -> ()) {
        let escapeEvents = events().filter({ event in
            event.keyCode == kVK_Escape && event.type == .keyDown
        })
        let disposable = escapeEvents.bind(onNext: { event in
            onEvent(event)
        })
        disposeBag.insert(disposable)
    }
    
    func observeLetterKeyDown(onEvent: @escaping (NSEvent) -> ()) {
        let alphabetKeyDownObservable = events()
            .filter({ event in
                guard let character = event.charactersIgnoringModifiers?.first else {
                    return false
                }
                return (character.isLetter || character.isNumber) && event.type == .keyDown
            })
        let disposable = alphabetKeyDownObservable.bind(onNext: { event in
            onEvent(event)
        })
        disposeBag.insert(disposable)
    }
    
    func observeDeleteKey(onEvent: @escaping (NSEvent) -> ()) {
        let deleteKeyDownObservable = events().filter({ event in
            return event.keyCode == kVK_Delete && event.type == .keyDown
        })
        let disposable = deleteKeyDownObservable.bind(onNext: { event in
            onEvent(event)
        })
        disposeBag.insert(disposable)
    }

    func observeSpaceKey(onEvent: @escaping (NSEvent) -> ()) {
        let spaceKeyDownObservable = events().filter({ event in
            return event.keyCode == kVK_Space && event.type == .keyDown
        })
        let disposable = spaceKeyDownObservable.bind(onNext: { event in
            onEvent(event)
        })
        disposeBag.insert(disposable)
    }
    
    private func events() -> Observable<NSEvent> {
        return inputListener.events
    }
}

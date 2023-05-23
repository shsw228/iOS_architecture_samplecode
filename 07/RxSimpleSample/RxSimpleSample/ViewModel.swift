//
//  ViewModel.swift
//  RxSimpleSample
//
//  Created by Kenji Tanaka on 2018/10/08.
//  Copyright © 2018年 Kenji Tanaka. All rights reserved.
//

import UIKit
import Combine
import CombineCocoa

final class ViewModel {
    private let model:ModelProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: ViewModel内で値を保持しているプロパティ
    private let validationTextSubject = PassthroughSubject<String, Never>()
    private let loadLabelColorSubject = PassthroughSubject<UIColor, Never>()

    //MARK: VCへの公開用プロパティ
    var validatedText: AnyPublisher<String,Never> {
        return validationTextSubject.eraseToAnyPublisher()
    }
    var loadLabelColor: AnyPublisher<UIColor,Never> {
        return loadLabelColorSubject.eraseToAnyPublisher()
    }

    init(model: ModelProtocol = Model()) {
        self.model = model
        model.validatePublisher //model内で公開しているvalidatePublisherをViewModelで購読する
            .sink { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success():
                    self.validationTextSubject.send("OK")
                    self.loadLabelColorSubject.send(.green)
                case .failure(let error):
                    self.validationTextSubject.send(error.errorText)
                    self.loadLabelColorSubject.send(.red)
                }
            }
            .store(in: &cancellables)
    }

    public func textChangedTo(id:String?, pass:String?) {
        model.validate(idText:id, passwordText: pass)
    }
}

extension ModelError {
    fileprivate var errorText: String {
        switch self {
        case .invalidIdAndPassword:
            return "IDとPasswordが未入力です。"
        case .invalidId:
            return "IDが未入力です。"
        case .invalidPassword:
            return "Passwordが未入力です。"
        }
    }
}

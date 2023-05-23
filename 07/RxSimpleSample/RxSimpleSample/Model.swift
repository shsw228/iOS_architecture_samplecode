//
//  Model.swift
//  RxSimpleSample
//
//  Created by Kenji Tanaka on 2018/10/08.
//  Copyright © 2018年 Kenji Tanaka. All rights reserved.
//

import Combine

enum ModelError: Error {
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
}
typealias ModelResult = Result<Void, ModelError>
protocol ModelProtocol {
    var validatePublisher: AnyPublisher<ModelResult,Never> { get } // ViewModelがvalidate結果を監視するためのプロパティ
    func validate(idText: String?, passwordText: String?)
}

final class Model: ModelProtocol {
private let validateSubject = PassthroughSubject<ModelResult, Never>()

    var validatePublisher: AnyPublisher<ModelResult, Never> {
        return validateSubject.eraseToAnyPublisher()
    }

    func validate(idText: String?, passwordText: String?){
        let result: ModelResult
        switch (idText, passwordText) {
        case (.none, .none):
            result = .failure(.invalidIdAndPassword)
        case (.none, .some):
            result = .failure(.invalidId)
        case (.some, .none):
            result = .failure(.invalidPassword)
        case (let idText?, let passwordText?):
            switch (idText.isEmpty, passwordText.isEmpty) {
            case (true, true):
                result = .failure(.invalidIdAndPassword)
            case (false, false):
                result = .success(())
            case (true, false):
                result = .failure(.invalidId)
            case (false, true):
                result = .failure(.invalidPassword)
            }
        }
        validateSubject.send(result) // validateSubjectにresultを反映する
    }
}

//
//  ViewController.swift
//  RxSimpleSample
//
//  Created by Kenji Tanaka on 2018/10/08.
//  Copyright © 2018年 Kenji Tanaka. All rights reserved.
//

import UIKit
import Combine
import CombineCocoa

final class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var validationLabel: UILabel!

    private var viewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: viewModelの公開しているvalidatedText,loadLabelColorを購読してUIに反映する
        viewModel.validatedText.sink { [weak self] validatedValue in
            self?.validationLabel.text = validatedValue
        }.store(in: &cancellables)

        viewModel.loadLabelColor.sink { [weak self] color in
            self?.validationLabel.textColor = color
        }.store(in: &cancellables)

        // MARK: CombineLatestを使ってどちらかのPublisherが更新された場合に動くようにする(Zipは両方の更新で動くため不可)
        Publishers.CombineLatest(idTextField.textPublisher, passwordTextField.textPublisher)
            .sink(receiveValue: {[weak self] (id, pass) in
                guard let self else { return }
                print("sinked")
                self.viewModel.textChangedTo(id: id, pass: pass)
            }).store(in: &cancellables)
    }
}


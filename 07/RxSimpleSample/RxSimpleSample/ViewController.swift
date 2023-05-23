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

        idTextField
            .textPublisher //AnyPublisher<String?, Never>
            .compactMap { $0 } //String?のnil消去
            .sink { [weak self] text in
                guard let self = self else { return }
                self.viewModel.textChangedTo(id: text, pass: self.passwordTextField.text)
                // Viewmodelを介してmodelにvalidationさせる

            }.store(in: &cancellables)

        passwordTextField
            .textPublisher //AnyPublisher<String?, Never>
            .compactMap { $0 } //String?のnil消去
            .sink { [weak self] text in
                guard let self = self else { return }
                self.viewModel.textChangedTo(id: self.idTextField.text, pass: text) // Viewmodelを介してmodelにvalidationさせる

            }.store(in: &cancellables)

    }
}


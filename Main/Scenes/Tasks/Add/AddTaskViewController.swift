//
//  AddTaskViewController.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 17/11/22.
//

import UIKit
import RxSwift

class AddTaskViewController: SceneViewController<AddTaskView> {
  private let addTaskViewModel: AddTaskViewModel
  private let navigation: AddTaskNavigation
  private let onDismiss: () -> Void

  let onAddNewTaskSubject = PublishSubject<Task>()
  var onAddNewTask: Observable<Task> { onAddNewTaskSubject }

  init(addTaskViewModel: AddTaskViewModel, navigation: AddTaskNavigation, onDismiss: @escaping () -> Void) {
    self.addTaskViewModel = addTaskViewModel
    self.navigation = navigation
    self.onDismiss = onDismiss
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupObservables()
  }

  override func setupLayout() {
    super.setupLayout()
  }

  func setupObservables() {
    contentView.titleTextFieldContainer.textField.rx.text
      .bind(to: addTaskViewModel.onTitleTextFieldSubject)
      .disposed(by: bag)

    contentView.descriptionTextFieldContainer.textView.rx.text
      .bind(to: addTaskViewModel.onDescriptionTextFieldSubject)
      .disposed(by: bag)

    contentView.priorityContainer.segmentedControl.rx.selectedSegmentIndex
      .bind(to: addTaskViewModel.onPriorityOptionSubject)
      .disposed(by: bag)

    addTaskViewModel.onEnabledSubmitButton
      .bind { [unowned self] isEnabled in
        contentView.submitButton.isEnabled = isEnabled
      }
      .disposed(by: bag)

    contentView.submitButton.rx.tap
      .bind { [unowned self] _ in
        contentView.titleTextFieldContainer.resignFirstResponder()
        addTaskViewModel.onSubmitButtonSubject.onNext(())
      }
      .disposed(by: bag)

    addTaskViewModel.onCompleteSubmit
      .bind { [unowned self] _ in
        navigation.closeModal()
        onDismiss()
      }
      .disposed(by: bag)
  }
}

protocol AddTaskNavigation {
  func closeModal()
}

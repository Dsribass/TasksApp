//
//  TaskDetailViewController.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 22/11/22.
//

import UIKit

class TaskDetailViewController: SceneViewController<TaskDetailView> {
  private let id: UUID

  init(id: UUID) {
    self.id = id
    super.init(
      nibName: String(describing: TaskDetailViewController.self),
      bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

import Render
import UIKit

class Example3ViewController: ViewController {

	private let scrollableComponent = ScrollableDemoComponentView()

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(scrollableComponent)
		let state = FooCollectionState()
		scrollableComponent.state = state
	}

	override func viewDidLayoutSubviews() {
		scrollableComponent.render(in: view.bounds.size)
	}
}

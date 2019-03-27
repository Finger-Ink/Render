import Render
import UIKit

class Example6ViewController: ViewController {

	private let component = PercentComponentView()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(component)
	}

	override func viewDidLayoutSubviews() {
		component.render(in: view.bounds.size)
		component.center = view.center
	}
}

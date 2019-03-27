import Foundation
import Render
import UIKit

class IndexViewController: UITableViewController {
	let states: [IndexState] = [
		IndexState(
			title: "Example 1 - Hello world",
			subtitle: "A simple component with static view hierarchy."),
		IndexState(
			title: "Example 2 - Nested Component",
			subtitle: "A component with a complex dynamic view hierarchy comprising of a nested component."),
		IndexState(
			title: "Example 3 - Scrolling Component",
			subtitle: "The contentsize for the wrapping scrollview component is automatically determined."),
		IndexState(
			title: "Example 4 - Animations",
			subtitle: "Passing the .animated option to the render function."),
		IndexState(
			title: "Example 5 - TableNode",
			subtitle: "Wraps the children nodes in UITableViewCells."),
		IndexState(
			title: "Example 6 - Layout values with %",
			subtitle: "You can express size, margins and padding as %.")
	]

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.separatorStyle = .none
		tableView.backgroundColor = Color.black
		tableView.dataSource = self
		tableView.reloadData()
		ViewController.styleNavigationBar(viewController: self)
		title = "INDEX"
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return states.count
	}

	override func tableView(_ tableView: UITableView,
	                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let id = CellPrototype.defaultIdentifier(IndexItemComponentView.self)
		let cell = tableView.dequeueReusableCell(withIdentifier: id) ??
			ComponentTableViewCell<IndexItemComponentView>()

		if let cell = cell as? ComponentTableViewCell<IndexItemComponentView> {
			cell.mountComponentIfNecessary(IndexItemComponentView())
			cell.state = states[indexPath.row]
			cell.render()
		}
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case 0: navigationController?.pushViewController(Example1ViewController(), animated: true)
		case 1: navigationController?.pushViewController(Example2ViewController(), animated: true)
		case 2: navigationController?.pushViewController(Example3ViewController(), animated: true)
		case 3: navigationController?.pushViewController(Example4ViewController(), animated: true)
		case 4: navigationController?.pushViewController(Example5ViewController(), animated: true)
		case 5: navigationController?.pushViewController(Example6ViewController(), animated: true)
		default: break
		}
	}
}

// MARK: - Index cells

struct IndexState: StateType {
	let title: String
	let subtitle: String
}

class IndexItemComponentView: ComponentView<IndexState> {

	override func construct(state: IndexState?, size: CGSize = CGSize.undefined) -> NodeType {
		return Node<UIView>() { view, layout, size in
			view.backgroundColor = Color.black
			layout.padding = 8
			layout.width = size.width
		}.add(children: [
			Fragments.paddedLabel(text: state?.title),
			Fragments.subtitleLabel(text: state?.subtitle)
		])
	}
}

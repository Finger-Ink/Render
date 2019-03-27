import Render
import UIKit

struct FooCollectionState: StateType {
	let foos: [FooState]
	init() {
		foos = (0 ..< randomInt(12, max: 48)).map { _ in FooState() }
	}
}

class ScrollableDemoComponentView: ComponentView<FooCollectionState> {

	override func construct(state: FooCollectionState?, size: CGSize = CGSize.undefined) -> NodeType {
		guard let state = state else {
			return NilNode()
		}
		return Node<UIScrollView>(identifier: "ScrollableFoos") { view, layout, size in
			(layout.width, layout.height) = (size.width, size.height)
		}.add(children: state.foos.map { foo in
			// We create a component for every item in the state collection and we add it as a
			// child for the main UIScrollView node.
			ComponentNode(type: FooComponentView.self, state: foo, size: size)
		})
	}
}

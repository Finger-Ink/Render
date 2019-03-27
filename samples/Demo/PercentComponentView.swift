import Foundation
import Render
import UIKit

class PercentComponentView: ComponentView<NilState> {

	required init() {
		super.init()
		// Optimization: The component doesn't have a dynamic hierarchy - this prevents the
		// reconciliation algorithm to look for differences in the component view hierarchy.
		defaultOptions = [.preventViewHierarchyDiff]
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("Not supported")
	}

	override func construct(state: NilState?, size: CGSize = CGSize.undefined) -> NodeType {
		return Node<UIView>() { view, layout, size in
			view.backgroundColor = Color.green
			layout.percent.height = 95%
			layout.percent.width = 95%
			layout.justifyContent = .center
		}.add(child: Node<UIView>() { view, layout, size in
			view.backgroundColor = Color.darkerGreen
			layout.percent.height = 90%
			layout.percent.width = 90%
		})
	}
}

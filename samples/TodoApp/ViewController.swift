import Dispatcher_iOS
import Render
import UIKit

class ViewController: UITableViewController {

	let dispatcher: Dispatcher

	init(dispatcher: Dispatcher = Dispatcher.default) {
		self.dispatcher = dispatcher
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		dispatcher.todoListStore.register(observer: self) { _ in
			self.tableView.reloadData()
		}

		super.viewDidLoad()
		tableView.backgroundColor = Color.black
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.separatorStyle = .none
		tableView.dataSource = self
		tableView.reloadData()

		title = "TODOS"

		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.green]
		navigationController?.navigationBar.barTintColor = Color.black
		navigationController?.navigationBar.tintColor = Color.green
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
		                                                    target: self,
		                                                    action: #selector(didTapAddButton))

		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
		                                                   target: self,
		                                                   action: #selector(didTapCancelButton))
	}

	private dynamic func didTapAddButton() {
		dispatcher.dispatch(action: Action.add)
	}

	private dynamic func didTapCancelButton() {
		dispatcher.dispatch(action: Action.clear)
	}
}

func createCard() -> NodeType {
	return Node<UIView>(identifier: "card") { view, layout, size in
		layout.alignSelf = .stretch
		layout.flexGrow = 1
		layout.margin = 28
		layout.flexDirection = .row
		view.backgroundColor = Color.white.withAlphaComponent(0.1)
	}
}

// MARK: - UITableViewDelegate

extension ViewController {

	override func tableView(_ tableView: UITableView,
	                        numberOfRowsInSection section: Int) -> Int {
		let TodoListState = dispatcher.todoListStore.state
		return TodoListState.todoList.count
	}

	override func tableView(_ tableView: UITableView,
	                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let id = CellPrototype.defaultIdentifier(TodoComponentView.self)
		let dequeued = tableView.dequeueReusableCell(withIdentifier: id)
		let cell = dequeued ?? ComponentTableViewCell<TodoComponentView>()

		guard let componentCell = cell as? ComponentTableViewCell<TodoComponentView> else {
			return cell
		}

		let TodoListState = dispatcher.todoListStore.state

		componentCell.mountComponentIfNecessary(TodoComponentView())
		componentCell.state = TodoListState.todoList[indexPath.row]
		componentCell.componentView?.delegate = self
		componentCell.render()
		return cell
	}
}

// MARK: - Component Delegate

extension ViewController: TodoComponentViewDelegate {

	/** The user finished adding a description for the todo item with the 'id' passed as argument. */
	func didNameTodo(id: String, title: String) {
		dispatcher.dispatch(action: Action.name(id: id, title: title))
	}

	/** The user tapped on the check button in the todo item with the 'id' passed as argument */
	func didCheckTodo(id: String) {
		dispatcher.dispatch(action: Action.check(id: id))
	}
}

import Foundation
import UIKit

public extension CGFloat {
	static let undefined: CGFloat = YGNaNSize.width
	static let max: CGFloat = 32768
	static let epsilon: CGFloat = CGFloat(Float.ulpOfOne)
	var maxIfZero: CGFloat { return self == 0 ? CGFloat.max : self }
	var undefinedIfZero: CGFloat { return self == 0 ? CGFloat.undefined : self }
}

public extension CGSize {
	static let undefined: CGSize = CGSize(width: CGFloat.undefined, height: CGFloat.undefined)
	static let max: CGSize = CGSize(width: CGFloat.max, height: CGFloat.max)
	static let epsilon: CGSize = CGSize(width: CGFloat.epsilon, height: CGFloat.epsilon)
}

public extension CGRect {
	mutating func normalize() {
		origin.x = origin.x.isNormal ? origin.x : 0
		origin.y = origin.y.isNormal ? origin.y : 0
		size.width = size.width.isNormal ? size.width : 0
		size.height = size.height.isNormal ? size.height : 0
	}
}

private var handleAnimatable: UInt8 = 0
private var handleHasNode: UInt8 = 0
private var handleNewlyCreated: UInt8 = 0

public extension UIView {

	var isAnimatable: Bool {
		get { return getBool(&handleAnimatable, self, defaultIfNil: true) }
		set { setBool(&handleAnimatable, self, newValue) }
	}

	internal var hasNode: Bool {
		get { return getBool(&handleHasNode, self, defaultIfNil: false) }
		set { setBool(&handleHasNode, self, newValue) }
	}

	internal var isNewlyCreated: Bool {
		get { return getBool(&handleNewlyCreated, self, defaultIfNil: false) }
		set { setBool(&handleNewlyCreated, self, newValue) }
	}
}

private func getBool(_ handle: UnsafeRawPointer!, _ object: UIView, defaultIfNil: Bool) -> Bool {
	return (objc_getAssociatedObject(object, handle) as? NSNumber)?.boolValue ?? defaultIfNil
}

private func getBool(_ handle: UnsafeRawPointer!, _ object: UIView, _ value: Bool) -> Bool {
	return (objc_getAssociatedObject(object, handle) as? NSNumber)?.boolValue ?? value
}

private func setBool(_ handle: UnsafeRawPointer!, _ object: UIView, _ value: Bool) {
	objc_setAssociatedObject(object,
	                         handle,
	                         NSNumber(value: value),
	                         .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}

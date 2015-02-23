//  Copyright (c) 2015 Rob Rix. All rights reserved.

/// An enum representing either a failure with an explanatory error, or a success with a result value.
public enum Result<T>: EitherType {
	case Failure(NSError)
	case Success(Box<T>)


	// MARK: EitherType

	public static func left(value: NSError) -> Result {
		return Failure(value)
	}

	public static func right(value: T) -> Result {
		return Success(Box(value))
	}

	public func either<Result>(ifLeft: NSError -> Result, _ ifRight: T -> Result) -> Result {
		switch self {
		case let Failure(error):
			return ifLeft(error)

		case let Success(v):
			return ifRight(v.value)
		}
	}
}


// MARK: - Imports

import Box
import Either
import Foundation

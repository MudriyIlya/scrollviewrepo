//
//  ViewController.swift
//  scrollviewrepo
//
//  Created by Илья Мудрый on 21.07.2023.
//

import UIKit

final class ViewController: UIViewController {

	// MARK: Constants

	private let imageHeight: CGFloat = 270.0

	// MARK: Subviews

	private lazy var imageView: UIImageView = {
		let imageView = UIImageView(
			frame: .init(
				x: 0,
				y: 0,
				width: view.frame.width,
				height: imageHeight
			)
		)
		imageView.image = UIImage(named: "tom")
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		return imageView
	}()

	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.delegate = self
		scrollView.contentSize.height = view.frame.height + imageHeight
		return scrollView
	}()

	// MARK: Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		addScrollView()
	}
}

// MARK: - Private
private extension ViewController {

	func addScrollView() {
		view.backgroundColor = .systemBackground
		view.addSubview(scrollView)
		scrollView.addSubview(imageView)
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			imageView.topAnchor.constraint(equalTo: view.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)

		])
	}
}

// MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offset = scrollView.contentOffset.y
		if offset <= .zero {
			imageView.frame.origin.y = offset
			imageView.frame.size.height = imageHeight - offset
		}
		scrollView.verticalScrollIndicatorInsets.top = imageHeight - offset - view.safeAreaInsets.top
	}
}

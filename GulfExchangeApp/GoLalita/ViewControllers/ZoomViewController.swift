import UIKit

class ZoomedImageViewController: UIViewController, UIScrollViewDelegate {

    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private var closeButton = UIButton(type: .system)

    init(image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupImageView()
        setupCloseButton()
        setupGestures()
    }

    private func setupScrollView() {
        scrollView.frame = view.bounds
        scrollView.delegate = self
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }

    private func setupImageView() {
        imageView.frame = scrollView.bounds
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.bounds.size
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }

    private func setupCloseButton() {
        // Add close button
//             closeButton = UIButton(type: .system)
//             closeButton.setTitle("Close", for: .normal)
//             closeButton.setTitleColor(.white, for: .normal)
//             closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//             closeButton.layer.cornerRadius = 15
//             closeButton.translatesAutoresizingMaskIntoConstraints = false
//             closeButton.addTarget(self, action: #selector(dismissZoom), for: .touchUpInside)
//             view.addSubview(closeButton)
        
        closeButton = UIButton(type: .custom)
            let closeButtonImage = UIImage(named: "close") // Replace with your image name
            closeButton.setImage(closeButtonImage, for: .normal)
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.addTarget(self, action: #selector(dismissZoom), for: .touchUpInside)
            view.addSubview(closeButton)

        // Set constraints for the close button
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }


    private func setupGestures() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
    }

    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        let pointInView = gesture.location(in: imageView)
        let newZoomScale: CGFloat

        if scrollView.zoomScale == scrollView.minimumZoomScale {
            newZoomScale = scrollView.maximumZoomScale
        } else {
            newZoomScale = scrollView.minimumZoomScale
        }

        let zoomRect = zoomRect(forScale: newZoomScale, withCenter: pointInView)
        scrollView.zoom(to: zoomRect, animated: true)
    }

    private func zoomRect(forScale scale: CGFloat, withCenter center: CGPoint) -> CGRect {
        let size = CGSize(width: view.bounds.size.width / scale, height: view.bounds.size.height / scale)
        let origin = CGPoint(x: center.x - (size.width / 2.0), y: center.y - (size.height / 2.0))
        return CGRect(origin: origin, size: size)
    }

    @objc private func dismissZoom() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        imageView.frame = scrollView.bounds
        scrollView.contentSize = imageView.bounds.size
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

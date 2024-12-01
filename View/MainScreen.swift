import UIKit

class MainScreen: UIView {
    
    // Lazy Loaded backgroundImage
    lazy var backgroundImage: UIImage = {
        guard let image = UIImage(named: "background") else {
            fatalError("Image bulunamadı")
        }
        return image
    }()
    
    // Lazy Loaded locationButton
    lazy var locationButton: UIButton = {
        let button = UIButton()
        let locationImage = UIImage(systemName: "location.circle.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold))
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.setImage(locationImage, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var symbolImage : UIImage = {
        guard let image = UIImage(systemName: "cloud.rain",withConfiguration: UIImage.SymbolConfiguration(pointSize: 100, weight: .medium)) else {
            fatalError("image bulunamadı")
        }
        image.withTintColor(.black)
        return image.withTintColor(.black, renderingMode: .alwaysOriginal)
    }()
    
    
    lazy var symbolImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = symbolImage
        return imageView
    }()
    
    // Lazy Loaded locationTextField
    lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.textAlignment = .right
        textField.returnKeyType = .go
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Lazy Loaded searchButton
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "magnifyingglass",                        withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var temperatureNumber : UILabel = {
        let label = UILabel()
        label.text = "18 "
        label.font = UIFont.systemFont(ofSize: 100)
        label.textColor = .black
        return label
    }()
    
    lazy var temperatureSymbol : UILabel = {
        let label = UILabel()
        label.text = "°"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 100)
        return label
    }()
    
    lazy var tempertureC : UILabel = {
        let label = UILabel()
        label.text = "C"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 100)
        return label
    }()
    
    lazy var city : UILabel = {
        let label = UILabel()
        label.text = "LVIV"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var temperatureStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.addArrangedSubview(temperatureNumber)
        stackView.addArrangedSubview(temperatureSymbol)
        stackView.addArrangedSubview(tempertureC)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    
    
    // Lazy Loaded headerStackView
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(locationButton)
        stackView.addArrangedSubview(locationTextField)
        stackView.addArrangedSubview(searchButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = 15
        stackView.addArrangedSubview(headerStackView)
        stackView.addArrangedSubview(symbolImageView)
        stackView.addArrangedSubview(temperatureStack)
        stackView.addArrangedSubview(city)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add stack view
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            locationTextField.widthAnchor.constraint(equalToConstant: 250)
            
        ])
    }
    
    // Required init method for decoding from storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

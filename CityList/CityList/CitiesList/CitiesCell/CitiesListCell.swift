//
//  CitiesListCell.swift
//  CityList
//
//  Created by Nikhil Singhal on 6/19/22.
//

import UIKit
import Combine

class CitiesListCell: UITableViewCell, RegistrableCellProtocol {
    private var subscriptions = Set<AnyCancellable>()

    let containerView: UIView = {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    let citiesListStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        stack.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let nameRegionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name Region"
        return label
    }()

    let codeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.00)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let capitalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var cellViewModel: CityListCellViewModal? {
        didSet {
            publishDetails()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = CitiesListCell.defaultIdentifier) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    override func prepareForReuse() {
        codeLabel.text = ""
        capitalLabel.text = ""
    }

    func setupView() {
        addViews()
        addConstraints()
    }

    private func addViews() {
        // Product details Stack
        [nameRegionTitle, codeLabel, capitalLabel].forEach { detail in
            citiesListStack.addArrangedSubview(detail)
        }

        // Container View
        containerView.addSubview(citiesListStack)

        contentView.addSubview(containerView)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            citiesListStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            citiesListStack.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            citiesListStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            citiesListStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

        ])
    }

    private func publishDetails() {
        guard let viewModel = cellViewModel else {
            return
        }


        nameRegionTitle.text = viewModel.cityData.name + " , " + viewModel.cityData.region
        codeLabel.text = viewModel.cityData.code
        capitalLabel.text = viewModel.cityData.capital

    }


}

//
//  ProfileDetailsView.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 30.06.21.
//

import UIKit

class ProfileDetailsView: UIView {
    
    ///FIX: massive code duplication. create custom label
    
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func set(title: String, value: String) {
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
    
    private func configure() {
        titleLabel.text = "Group"
        valueLabel.text = "Value"
        
        valueLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        
        titleLabel.adjustsFontSizeToFitWidth = true
        valueLabel.adjustsFontSizeToFitWidth = true
        
        titleLabel.textAlignment = .center
        valueLabel.textAlignment = .center
        
        layer.cornerRadius = 12
        clipsToBounds      = true
        
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -bounds.height * 0.15),
            valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -8)

        ])
    }

}

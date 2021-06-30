//
//  ProfileDetailsView.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 30.06.21.
//

import UIKit

class ProfileDetailsView: UIView {
    
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
        layer.cornerRadius = 12
        clipsToBounds      = true
        
        for label in [titleLabel, valueLabel] {
            addSubview(label)
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
                label.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 8),
                label.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -8),
            ])
        }
        
        valueLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,
                                                constant: -bounds.height * 0.15),
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor,
                                            constant: 8),
        ])
    }

}

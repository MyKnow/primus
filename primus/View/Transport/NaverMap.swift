//
//  NaverMap.swift
//  primus
//
//  Created by 정민호 on 6/29/24.
//

import SwiftUI
import NMapsMap

struct NaverMap: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator.shared
    }
    
    func makeUIView(context: Context) -> UIView {
        let naverMapView = context.coordinator.getNaverMapView()
        let containerView = UIView()
        
        // 네이버 맵 뷰를 컨테이너 뷰에 추가
        containerView.addSubview(naverMapView)
        
        // 네이버 맵 뷰의 레이아웃 설정
        naverMapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            naverMapView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            naverMapView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            naverMapView.topAnchor.constraint(equalTo: containerView.topAnchor),
            naverMapView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        // 코너 반경 적용
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        
        return containerView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    NaverMap()
}

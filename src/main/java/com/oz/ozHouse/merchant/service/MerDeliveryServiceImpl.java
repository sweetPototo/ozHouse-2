package com.oz.ozHouse.merchant.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.oz.ozHouse.domain.OrderTb;
import com.oz.ozHouse.domain.ProInform;
import com.oz.ozHouse.dto.merchant.DeliveryDTO;
import com.oz.ozHouse.dto.merchant.DeliverySearchDTO;
import com.oz.ozHouse.dto.merchant.ProinformDTO;
import com.oz.ozHouse.merchant.repository.orderTbRepository.OrderTbRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MerDeliveryServiceImpl implements MerDeliveryService {
	private final OrderTbRepository orderRepository;
	
	private List<DeliveryDTO> setListDto(List<OrderTb> ot){
		List<DeliveryDTO> listDto = new ArrayList<>();
		for(OrderTb o : ot) {
			DeliveryDTO dto = DeliveryDTO.builder()
					.oderNum(o.getONum())
					.memberId(o.getMember().getMemberId())
					.regDate(o.getRegDate())
					.orderItems(setOrderItems(o.getOrderItems()))
					.order_comment(o.getOComment())
					.order_delivery_now(o.getODelnow())
					.build();
			listDto.add(dto);
		}
		return listDto;
	}
	
	private List<ProinformDTO> setOrderItems(List<ProInform> pi){
		List<ProinformDTO> piList = new ArrayList<>();
		for(ProInform p : pi) {
			ProinformDTO dto = ProinformDTO.builder()
					.proInNum(p.getProInNum())
					.proNum(p.getProduct().getProNum())
					.proName(p.getProduct().getProName())
					.quantity(p.getQuantity())
					.oRefund(p.getORefund())
					.realPrice(p.getRealPrice())
					.build();
			piList.add(dto);
		}
		return piList;
	}
	
//	@Transactional
//	@Override
//	public List<DeliveryDTO> deliveryList(int merNum) {
//		System.out.println("배송전체조회");
//		//List<OrderTb> ot = orderRepository.findOrdersByMerNum(merNum);
//		List<OrderTb> ot = orderRepository.findByOrderItemsProductMerchantMerNumAndOstatus(merNum, "ok");
//		List<DeliveryDTO> listDto = setListDto(ot);
//		return listDto;
//	}
	
	@Transactional
	@Override
	public List<DeliveryDTO> deliveryList(int merNum) {
		System.out.println("배송전체조회");
	    // 주문 리스트를 조회 (첫 번째 쿼리)
	    List<OrderTb> ot = orderRepository.findByOrderItemsProductMerchantMerNumAndOstatus(merNum, "ok");

	    // N+1 문제를 유발하는 방식
	    List<DeliveryDTO> listDto = new ArrayList<>();
	    for(OrderTb o : ot) {
	        // 각 주문에 대해 연관된 orderItems를 개별적으로 조회 (N개의 추가 쿼리 발생)
	        List<ProInform> orderItems = o.getOrderItems();
	        
	        // 각 orderItem에 대해 별도의 DTO로 변환
	        List<ProinformDTO> piList = new ArrayList<>();
	        for(ProInform p : orderItems) {
	            ProinformDTO dto = ProinformDTO.builder()
	                    .proInNum(p.getProInNum())
	                    .proNum(p.getProduct().getProNum())
	                    .proName(p.getProduct().getProName())
	                    .quantity(p.getQuantity())
	                    .oRefund(p.getORefund())
	                    .realPrice(p.getRealPrice())
	                    .build();
	            piList.add(dto);
	        }
	        
	        DeliveryDTO dto = DeliveryDTO.builder()
	                .oderNum(o.getONum())
	                .memberId(o.getMember().getMemberId())
	                .regDate(o.getRegDate())
	                .orderItems(piList)
	                .order_comment(o.getOComment())
	                .order_delivery_now(o.getODelnow())
	                .build();
	        listDto.add(dto);
	    }

	    return listDto;
	}


	@Override
	public List<DeliveryDTO> deliveryLikeList(Map<String, String> map) {
		System.out.println("배송상태별조회");
		List<OrderTb> ot = orderRepository.findOrdersLikeByMerNum(map.get("merNum"), map.get("mode"));
		List<DeliveryDTO> listDto = setListDto(ot);
		return listDto;
	}
	@Override
	public List<DeliveryDTO> searchDeliveryList(DeliverySearchDTO dto) {
		System.out.println("배송상태별조건조회");
		List<OrderTb> ot = orderRepository.searchDeliveryList(dto);
		List<DeliveryDTO> listDto = setListDto(ot);
		return listDto;
	}

}

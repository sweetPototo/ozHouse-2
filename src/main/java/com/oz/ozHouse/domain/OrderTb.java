package com.oz.ozHouse.domain;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.oz.ozHouse.domain.OrderTb;
import com.oz.ozHouse.domain.common.PhoneNumber;

import jakarta.persistence.AttributeOverride;
import jakarta.persistence.AttributeOverrides;
import jakarta.persistence.Column;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;

@Entity
@Getter
@AttributeOverride(name = "regDate", column = @Column(name = "oDate"))
public class OrderTb {
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long oCode;
    
    private int oNum;
	
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="memberId")
    private Member member;			//구매자 정보
    
    private String oName;			//주문자명
    
    @Embedded
    @AttributeOverrides({
		@AttributeOverride(name = "phoneNumber1", column = @Column(name = "oHp1")),
		@AttributeOverride(name = "phoneNumber2", column = @Column(name = "oHp2")),
		@AttributeOverride(name = "PhoneNumber3", column = @Column(name = "oHp3"))
    })
    private PhoneNumber oHp;		//주문자 전화번호
    //--------------------------------------------
    
    private int productNum;			//구매 상품
    
    private int oAssemblycost;		//상품 조립비
    
    private int oDiscount;			//상품 할인 금액
    
    private int oDiscoupon;			//쿠폰 사용 금액
    //--------------------------------------------
    
    private int oDispoint;			//사용 포인트 금액
    
    private int oPrice;				//최종 상품 주문 금액
    
    private String oComment;
    
    private int oCount;
    
    private String oPlace;			//배송지
    
    private String oPostcode;		//우편번호
    
    private String oDelnow;			//배송상태
	
    private String oLike;			//주문상태
    
    private String oRefund;			//판매자 처리 여부
    
	@DateTimeFormat(pattern = "yy/MM/dd")
    private LocalDate oCanceldate;
    

}
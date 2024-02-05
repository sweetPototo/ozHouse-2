package com.oz.ozHouse.domain;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.oz.ozHouse.domain.OrderTb;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Getter;
import lombok.Setter;

@Entity
@Setter
@Getter
public class OrderTb {
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private long oCode;
	
    @ManyToOne
    @JoinColumn(name="memberId")
    private Member memberId;
    
    private int productNum;
    private int oPrice;
    private int oDiscoupon;
    private int oDiscount;
    private int oDispoint;
    private String oComment;
    private int oCount;
    private String oDate;
    private String oPlace;
    private String oDelnow;
	@DateTimeFormat(pattern = "yy/MM/dd")
    private LocalDate oCanceldate;
    private String oLike;
    private String oRefund;
    private int oAssemblycost;
    private int oNum;
    private String oName;
    private String oHp1;
    private String oHp2;
    private String oHp3;
    private String oPostcode;

}
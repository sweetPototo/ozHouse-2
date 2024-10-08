package com.oz.ozHouse.client.repository;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import com.oz.ozHouse.domain.Member;
import com.oz.ozHouse.domain.MerCoupon;
import com.oz.ozHouse.domain.UserCoupon;

import jakarta.transaction.Transactional;

public interface UserCouponRepository extends JpaRepository<UserCoupon, Integer>{
	
	 List<UserCoupon> findByMember_MemberId(String memberId);
 
	 @Transactional
	 @EntityGraph(attributePaths = {"merCoupon"})
	 UserCoupon findByMerCouponAndMember(MerCoupon merCoupon, Member member);
	 
	 int countByMember_MemberId(String memberId);
	 
}

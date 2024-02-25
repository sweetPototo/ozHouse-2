package com.oz.ozHouse.market.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oz.ozHouse.domain.Chatt;
import com.oz.ozHouse.dto.ChattDTO;
import com.oz.ozHouse.market.repository.ChattRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChattServiceImpl implements ChattService {

    private final ChattRepository chattRepository;

    private final ChattRoomService chattRoomService;
    
    @Override
    public Chatt saveMessage(ChattDTO chattDTO) {
        // 채팅방의 참여자 목록을 가져옵니다.
        List<Object> participants = chattRoomService.findParticipantsByRoomNum(chattDTO.getRoomNum());

        // 발신자가 아닌 다른 참여자를 수신자로 설정합니다.
        String recipient = (String) participants.stream()
                                        .filter(participant -> !participant.equals(chattDTO.getSender()))
                                        .findFirst()
                                        .orElseThrow(() -> new IllegalStateException("수신자를 결정할 수 없습니다."));

        // ChattDTO에 수신자를 설정합니다.
        chattDTO.setRecipient(recipient);

        // ChattDTO를 Chatt 엔터티로 변환하고, 모든 필드를 포함하여 올바르게 설정합니다.
        Chatt chatt = new Chatt(chattDTO);

        // 여기에서 채팅방 번호를 올바르게 설정합니다.
        chatt.setChattRoom(chattRoomService.findRoomByNum(chattDTO.getRoomNum()));

        // Chatt 엔터티를 저장합니다.
        return chattRepository.save(chatt);
    }
}

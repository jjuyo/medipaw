package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.LikesVO;
import org.medipaw.domain.PetMapVO;
import org.medipaw.mapper.LikesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class LikesServiceImpl implements LikesService {

    @Autowired
    private LikesMapper likesMapper;

    @Override
    public void addLike(LikesVO like) {
        likesMapper.insertLike(like);
    }

    @Override
    public void removeLike(String placeNo, String id) {
        likesMapper.deleteLike(placeNo, id);
    }

    @Override
    public List<PetMapVO> getUserLikes(String id) {
		log.info("dld????");

        return likesMapper.getUserLikes(id);
    }
    
    @Override
    public List<String> getLikedPlaces(String id) {
        return likesMapper.getLikedPlaces(id);
    }
}
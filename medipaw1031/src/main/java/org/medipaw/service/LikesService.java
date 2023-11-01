package org.medipaw.service;

import java.util.List;

import org.medipaw.domain.LikesVO;
import org.medipaw.domain.PetMapVO;

public interface LikesService {
    void addLike(LikesVO like);
    void removeLike(String placeNo, String id);
    List<PetMapVO> getUserLikes(String id);
    List<String> getLikedPlaces(String id);


}

	


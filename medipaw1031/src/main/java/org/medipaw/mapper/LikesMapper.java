package org.medipaw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.medipaw.domain.LikesVO;
import org.medipaw.domain.PetMapVO;

public interface LikesMapper {
    void insertLike(LikesVO like);
    void deleteLike(@Param("placeNo") String placeNo, @Param("id") String id);
    List<PetMapVO> getUserLikes(@Param("id") String id);
    List<String> getLikedPlaces(String id);


}


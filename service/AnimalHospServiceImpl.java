package org.medipaw.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.medipaw.domain.Criteria;
import org.medipaw.domain.AnimalHospVO;
import org.medipaw.mapper.AnimalHospMapper;

@Service
@AllArgsConstructor
@Slf4j
public class AnimalHospServiceImpl implements AnimalHospService {
	private final AnimalHospMapper animalHospMapper;
	@Override
	public List<AnimalHospVO> selectAllPaging(Criteria cri) {//여기서 시작 Mapper 접근해서 데이터 불러옴 그리고 데이터 Vo 에 저장하는듯		
		log.info("list..........");
		return animalHospMapper.selectAllPaging(cri);
	}
	
	@Override
	public AnimalHospVO select(int ano) {
		log.info("view..........");
		return animalHospMapper.view(ano);
	}

	@Override
	public int totalCount(Criteria cri) {
		log.info("totalCount..........");
		return animalHospMapper.totalCount(cri);
	}

	@Override
	public boolean modify(AnimalHospVO avo) {
		log.info("update...." + avo);
		boolean result = animalHospMapper.update(avo);
		return result;
	}

	@Override
	public boolean remove(String sid) {
		log.info("delete...." + sid);
		boolean result = animalHospMapper.delete(sid);
		return result;
	}

	@Override
	public boolean register(AnimalHospVO avo) {
		log.info("register...." + avo);
		boolean result = animalHospMapper.insert(avo);
		return result;
	}

	@Override
	public List<AnimalHospVO> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AnimalHospVO> selectByAddr(Criteria cri, String addr) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AnimalHospVO> selectByMap(Criteria cri, double aLatitude, double aHardness) {
		log.info("map_search_list..........");
		return animalHospMapper.searchByMap(cri,aLatitude, aHardness);
	}

	@Override
	public List<AnimalHospVO> insertData(AnimalHospVO avo) {
		// TODO Auto-generated method stub
		return null;
	}
}

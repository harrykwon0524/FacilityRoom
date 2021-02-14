package com.facility.room;

import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import facility.Facility;
import facility.FacilityDAO;



@RestController
public class ExaController {

	
	
	@RequestMapping(value = "/greeting")
	@ResponseBody

	public List<Facility> boardList() {
		FacilityDAO dao = new FacilityDAO();
		
		return dao.getAllFacility();
	}
}

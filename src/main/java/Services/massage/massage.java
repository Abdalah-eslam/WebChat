package Services.massage ;

import java.util.ArrayList;
import java.util.List;

import DAO.massagedao;
import DTO.massagedto;
import Models.Massage;

public class massage implements Imassage {
	
	private massagedao massagedao ;

	public massage() {
		super();
		this.massagedao = new massagedao();
	}

	@Override
	public ArrayList<massagedto> getMassagebyCoversation(String conversationId) {
		
	return	massagedao.getAllmassage(conversationId);
		
		
	}

	@Override
	public boolean addMassage(Massage massage) {
	return	massagedao.addMassage(massage);
	}

	@Override
	public void deleteMassage(Long massageId, Long userId) {
		massagedao.deletemassage(massageId, userId);
		
	}

	@Override
	public boolean editMassage(Long massageId, Long userId, String content) {
		return massagedao.editMassage(massageId, userId, content);
	}

	
	
}
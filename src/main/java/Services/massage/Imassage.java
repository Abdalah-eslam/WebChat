package Services.massage ;

import java.util.ArrayList;
import java.util.List;

import DTO.massagedto;
import Models.Massage;

public interface Imassage {
	
	public ArrayList<massagedto> getMassagebyCoversation(String conversationId);
	public boolean addMassage (Massage massage );
	public void deleteMassage(Long massageId, Long userId);
	public boolean editMassage(Long massageId , Long userId , String content);
	
}
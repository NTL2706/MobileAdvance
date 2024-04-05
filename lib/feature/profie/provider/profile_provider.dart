import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/profie/repo/profie_repo.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier{
  AuthResult? status;
  ProfileRepository profileRepository = ProfileRepository();
  Future<void> getAllTechStack()async{
    await profileRepository.getAllTechStack();
  
  }

  Future<void> getAllSkillSet()async{
    await profileRepository.getAllSkillSet();
    notifyListeners();
  }

  Future<void> createProfieForStudent(
    {
        required String token, 
        required List<String> skillSets, 
        required String techStackId}
      )async{
    
    status = await profileRepository.createProfieForStudent(
      skillSets: skillSets,
      techStackId: techStackId,
      token: token
    );
    notifyListeners();
  }

  Future<void> createProfieForCompany(
{
    required String companyName,
    required int size,
    required String website,
    required String description,required String token}
      )async{
    
    status = await profileRepository.createProfieForCompany(
      companyName: companyName,
      description: description,
      token: token,
      size: size,
      website: website
    );
    notifyListeners();
  }

  
}


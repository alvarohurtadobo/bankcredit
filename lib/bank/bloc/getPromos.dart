// ignore_for_file: file_names
import 'package:credidiunsa_app/bank/model/promo.dart';
import 'package:credidiunsa_app/common/repository/api.dart';

Future<bool> getPromosAndNovels()async {
  BackendResponse myRes = await API.getPromos();
  if(myRes.status==200){
    myPromos = myRes.myBody["Lista"].map<Promo>((res)=>Promo.fromBackendResponse(res)).toList();
  }
  myNovelties = myPromos.where((element) => element.idType==2).toList();
  myPromos = myPromos.where((element) => element.idType==1).toList();
  return true;
}
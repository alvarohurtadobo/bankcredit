class CuotaMensual {
  double cuota = 0.0;
  double debtInterest = 0.0;
  double normalInterest = 0.0;
  double insurance = 0.0;
  double capital = 0.0;
  double total = 0.0;

  CuotaMensual.fromBackendResponse(Map<String, dynamic> response){
    cuota = (response["Cuota"]??0.0)*1.0;
    debtInterest = (response["InteresMora"]??0.0)*1.0;
    normalInterest = (response["InteresCorriente"]??0.0)*1.0;
    insurance = (response["Seguro"]??0.0)*1.0;
    capital = (response["Capital"]??0.0)*1.0;
    total = (response["Total"]??0.0)*1.0;
  }
}
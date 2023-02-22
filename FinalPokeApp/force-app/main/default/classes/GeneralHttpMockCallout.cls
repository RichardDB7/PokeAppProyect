global with sharing class GeneralHttpMockCallout implements HttpCalloutMock{
  //variables que retornan la respuesta simulada
  protected String body;
  protected Integer statusCode;
  //Constuctor que establece el cuerpo y statuscode de los valores proporcionados
public GeneralHttpMockCallout(String body,Integer statusCode) {
      this.body = body;
      this.statusCode = statusCode;
  }    
    //retorno de la respuesta simulada implementado de la interfaz httpCalloutMock
  global HTTPResponse respond(HTTPRequest request) {
      HttpResponse res = new HttpResponse();
      res.setBody(this.body);
      res.setStatusCode(statusCode);
      return res;
  }
}

unit uRestSession;

interface

uses
  Web.HTTPApp;

type
  TRestSession = class
    private
      FRequest : TWebRequest;
      FResponse : TWebResponse;
    public
      procedure ExecuteGetCustomers();
      procedure ExecuteGetProducts();
      procedure ExecuteGetWeighings();
      procedure ExecuteDoWeighing();
      procedure ExecuteDoLogin();
      function CheckUser(const pUserLogin, pUserPassword : String) : Boolean;

      constructor Create(pRequest: TWebRequest; pResponse: TWebResponse); reintroduce; overload;
      destructor Destroy; override;
  end;

implementation

uses
  cManagerUser, cItemUser, System.SysUtils, OverbyteIcsSuperObject,
  cManagerProducts, cItemProduct, cItemCustomer, cManagerCustomers,
  cItemWeighing, cManagerWeighings, System.NetEncoding, System.Classes;

{ TRestSession }

constructor TRestSession.Create(pRequest: TWebRequest; pResponse: TWebResponse);
begin
  inherited Create();

  Self.FRequest := pRequest;
  Self.FResponse := pResponse;
end;

destructor TRestSession.Destroy;
begin

  inherited;
end;

procedure TRestSession.ExecuteDoLogin;
begin
  if not Assigned(Self.FRequest) then
    raise Exception.Create('Request not exist');

  //var iJsonResp : ISuperObject := SO();
  //try
    try
      if not (Self.FRequest.MethodType in [mtGet]) then
      begin
        if Assigned(Self.FResponse) then
          Self.FResponse.StatusCode := 405;

        raise Exception.Create('405: Method Not Allowed'); //  Response.Content := '{"error": "405: Method Not Allowed"}';
      end;

      var authHeader : String := Self.FRequest.GetFieldByName('Authorization');

      if not AuthHeader.StartsWith('Basic ') then
      begin
        Self.FResponse.StatusCode := 401;
        Self.FResponse.ReasonString  := 'Unauthorized';
        Exit;
      end;

      var authToken : String := AuthHeader.Substring(6); //usuwamy "Basic " z nag³ówka
      authToken := TNetEncoding.Base64.Decode(authToken);

      var apiUser : String := '';
      var apiPassword : String := '';
      var strLst : TStringList := TStringList.Create;
      try
        strLst.LineBreak := ':';
        strLst.Text := authToken;
        if strLst.Count > 0 then
          apiUser  := strLst[0];

        if strLst.Count > 1 then
          apiPassword  := strLst[1];
      finally
        strLst.Free;
      end;

      if not Self.CheckUser(apiUser, apiPassword) then
        raise Exception.Create('Nieprawid³owy login lub has³o.');

      Self.FResponse.StatusCode := 200; //sprawdzanie uzytkownika odbylo sie juz wczesniej
    except
      if Assigned(Self.FResponse) and (Self.FResponse.StatusCode = 200) then
        Self.FResponse.StatusCode := 400; //Bad Request

      raise;
    end;
    //Self.FResponse.Content := iJSonResp.AsJSon(True);
  //finally
    //iJSonResp := nil;
  //end;
end;

procedure TRestSession.ExecuteDoWeighing;
const
  JF_MESSAGE : String = 'message';
  JF_WEIGHING : String = 'weighing';
begin
  if not Assigned(Self.FRequest) then
    raise Exception.Create('Request not exist');

  var iJsonResp : ISuperObject := SO();
  var requestWeighing : TItemWeighing := nil;
  try
    try
      if not (Self.FRequest.MethodType in [mtPost]) then
      begin
        if Assigned(Self.FResponse) then
          Self.FResponse.StatusCode := 405;

        raise Exception.Create('405: Method Not Allowed'); //  Response.Content := '{"error": "405: Method Not Allowed"}';
      end;

      var iRequestArgs : ISUperObject := nil;
      if (Self.FRequest.Content <> '') then
      begin
        iRequestArgs := SO(Utf8ToAnsi(Self.FRequest.Content));
        if not Assigned(iRequestArgs) then
          raise Exception.Create('Bad JSON struct in Request.Content');
      end; //weryfikacja parametr˜w

      if Assigned(iRequestArgs) and not (iRequestArgs.DataType in [stObject, stArray]) then
        raise Exception.Create('Bad JSON struct in Request.Content');

      requestWeighing := TItemWeighing.JsonToWeighing(iRequestArgs);
      var isOk : Boolean := False;
      var errMsg : String := 'Nie znaleziono kontrahenta';
      var customer : TItemCustomer := nil;
      for var I : Integer := 0 to TManagerCustomers.Instance.CustomerList.Count - 1 do
      begin
        if TManagerCustomers.Instance.CustomerList[I].Id <> requestWeighing.Customer.IdErp then
          Continue;

        isOk := True;
        customer := TManagerCustomers.Instance.CustomerList[I];
        errMsg := '';
        Break;
      end;

      if not isOk then
      begin
        Self.FResponse.StatusCode := 400;
        iJsonResp.S[JF_MESSAGE] := errMsg;
        Self.FResponse.Content := iJSonResp.AsJSon(True);
        Exit;
      end;

      errMsg := 'Nieaktualny kontrahent';
      isOk := Assigned(customer) and (customer.NIP = requestWeighing.Customer.NIP)
              and (customer.Name = requestWeighing.Customer.Name) and (customer.Code = requestWeighing.Customer.Code);

      if not isOk then
      begin
        Self.FResponse.StatusCode := 400;
        iJsonResp.S[JF_MESSAGE] := errMsg;
        Self.FResponse.Content := iJSonResp.AsJSon(True);
        Exit;
      end;

      isOk := False;
      errMsg := 'Nie zaneleziono produktu';
      var product : TItemProduct := nil;
      for var I : Integer := 0 to TManagerProducts.Instance.ProductList.Count - 1 do
      begin
        if TManagerProducts.Instance.ProductList[I].Id <> requestWeighing.Product.IdErp then
          Continue;

        isOk := True;
        product := TManagerProducts.Instance.ProductList[I];
        errMsg := '';
        Break;
      end;

      if not isOk then
      begin
        Self.FResponse.StatusCode := 400;
        iJsonResp.S[JF_MESSAGE] := errMsg;
        Self.FResponse.Content := iJSonResp.AsJSon(True);
        Exit;
      end;

      errMsg := 'Nieaktualny produkt';
      isOk := Assigned(product) and (product.Code = requestWeighing.Product.Code)
              and (product.Name = requestWeighing.Product.Name) and (product.Price = requestWeighing.Product.Price);

      if not isOk then
      begin
        Self.FResponse.StatusCode := 400;
        iJsonResp.S[JF_MESSAGE] := errMsg;
        Self.FResponse.Content := iJSonResp.AsJSon(True);
        Exit;
      end;

      TManagerWeighings.Instance.InsertUpdateWeighing(requestWeighing);

      iJsonResp.O[JF_WEIGHING] := requestWeighing.ToJson();
      iJsonResp.S[JF_MESSAGE] := '';
      Self.FResponse.Content := iJSonResp.AsJSon(True);
      Self.FResponse.StatusCode := 200;

      TManagerWeighings.Instance.GetWeighingsFromDb;
    except
      if Assigned(Self.FResponse) and (Self.FResponse.StatusCode = 200) then
        Self.FResponse.StatusCode := 400; //Bad Request

      raise;
    end;
  finally
    if Assigned(requestWeighing) then
      requestWeighing.Free;

    iJSonResp := nil;
  end;
end;

procedure TRestSession.ExecuteGetCustomers;
const
  JF_CUSTOMERS : String = 'customers';
begin
  if not Assigned(Self.FRequest) then
    raise Exception.Create('Request not exist');

  var iJsonResp : ISuperObject := SO();
  try
    try
      if not (Self.FRequest.MethodType in [mtGet]) then
      begin
        if Assigned(Self.FResponse) then
          Self.FResponse.StatusCode := 405;

        raise Exception.Create('405: Method Not Allowed'); //  Response.Content := '{"error": "405: Method Not Allowed"}';
      end;

      iJsonResp.O[JF_CUSTOMERS] := SA([]);
      for var customer : TItemCustomer in TManagerCustomers.Instance.CustomerList do
      begin
        ijsonResp.A[JF_CUSTOMERS].Add(customer.ToJson());
      end;

      Self.FResponse.StatusCode := 200;
    except
      if Assigned(Self.FResponse) and (Self.FResponse.StatusCode = 200) then
        Self.FResponse.StatusCode := 400; //Bad Request

      raise;
    end;
    Self.FResponse.Content := iJSonResp.AsJSon(True);
  finally
    iJSonResp := nil;
  end;
end;

procedure TRestSession.ExecuteGetProducts;
const
  JF_PRODUCTS : String = 'products';
begin
  if not Assigned(Self.FRequest) then
    raise Exception.Create('Request not exist');

  var iJsonResp : ISuperObject := SO();
  try
    try
      if not (Self.FRequest.MethodType in [mtGet]) then
      begin
        if Assigned(Self.FResponse) then
          Self.FResponse.StatusCode := 405;

        raise Exception.Create('405: Method Not Allowed');
      end;

      iJsonResp.O[JF_PRODUCTS] := SA([]);
      for var product : TItemProduct in TManagerProducts.Instance.ProductList do
      begin
        ijsonResp.A[JF_PRODUCTS].Add(product.ToJson());
      end;

      Self.FResponse.StatusCode := 200;
    except
      if Assigned(Self.FResponse) and (Self.FResponse.StatusCode = 200) then
        Self.FResponse.StatusCode := 400; //Bad Request

      raise;
    end;
    Self.FResponse.Content := iJSonResp.AsJSon(True);
  finally
    iJSonResp := nil;
  end;
end;

procedure TRestSession.ExecuteGetWeighings;
const
  JF_WEIGHINGS : String = 'weighings';
begin
  if not Assigned(Self.FRequest) then
    raise Exception.Create('Request not exist');

  var iJsonResp : ISuperObject := SO();
  try
    try
      if not (Self.FRequest.MethodType in [mtPost]) then
      begin
        if Assigned(Self.FResponse) then
          Self.FResponse.StatusCode := 405;

        raise Exception.Create('405: Method Not Allowed'); //  Response.Content := '{"error": "405: Method Not Allowed"}';
      end;

      iJsonResp.O[JF_WEIGHINGS] := SA([]);
      for var weighing : TItemWeighing in TManagerWeighings.Instance.WeighingList do
      begin
        ijsonResp.A[JF_WEIGHINGS].Add(weighing.ToJson());
      end;

      Self.FResponse.StatusCode := 200;
    except
      if Assigned(Self.FResponse) and (Self.FResponse.StatusCode = 200) then
        Self.FResponse.StatusCode := 400; //Bad Request

      raise;
    end;
    Self.FResponse.Content := iJSonResp.AsJSon(True);
  finally
    iJSonResp := nil;
  end;
end;

function TRestSession.CheckUser(const pUserLogin, pUserPassword : String) : Boolean;
begin
  Result := False;
  var user : TItemUser := TItemUser.Create;
  user.Login := pUserLogin;
  user.Password := pUserPassword;

  var iJsonResp : ISuperObject := SO();
  try
    Result := TManagerUser.Instance.CheckUser(user);

    iJsonResp.I['user_id'] := user.Id;
    iJsonResp.S['user_f_name'] := user.FirstName;
    iJsonResp.S['user_l_name'] := user.LastName;
    Self.FResponse.Content := iJSonResp.AsJSon(True);
  finally
    user.Free;
    iJsonResp := nil;
  end;
end;

end.

unit cRestClient;

interface

uses
  cItemUser, cItemWeighing, System.Generics.Collections, cItemProduct,
  cItemCustomer, cTypes, iApiClient, cConfig, IdHTTP, IdSSLOpenSSLHeaders,
  OverbyteIcsSuperObject, System.Classes;

type
  TRestClientApi = class(TInterfacedObject, IClientApi)
    private
      FRestConfig : TRestClientConfig;
      FUrl : String;
      FHostname : String;

      procedure IdOnStatusInfoEx(ASender: TObject; const AsslSocket: PSSL; const AWhere, Aret: Integer;
        const AType, AMsg: string);

      procedure PrepareIdHttp(pIdHttp : TIdHttp; const pEndpoint : String);
      function GetResult(const pIdHttp : TIdHttp; const pOutputStream : TStringStream) : ISuperObject;

      procedure FreeIdHttp(pIdHttp : TIdHttp);
    public
      function LogInUser(const pUser : TItemUser) : TApiResponse;
      function GetProducts(pProductList : TObjectList<TItemProduct>) : TApiResponse;
      function GetCustomers(pCustomerList : TObjectList<TItemCustomer>) : TApiResponse;
      function GetWeighings(pWeighingList : TObjectList<TItemWeighing>; const pSearchFilter : TSearchFilters) : TApiResponse;
      function GetWeighingData(const pIdErpWeighing : Integer) : TApiResponse;
      function PostWeighing(const pWeighing : TItemWeighing) : TApiResponse;
  end;

implementation

uses
  System.SysUtils, IdURI, cManagerUser, IdSSLOpenSSL, IdLogFile, uConsts;



{ TRestClientApi }

procedure TRestClientApi.PrepareIdHttp(pIdHttp : TIdHttp;
  const pEndpoint: String);
begin
  if not Assigned(pIdHttp) then
    raise Exception.Create(Self.ClassName + '.GetResult: idHttp not assigned');

  Self.FUrl := Self.FRestConfig.ApiUrl;

  if Self.FUrl[Self.Furl.Length - 1] = '/' then
    Self.FUrl := Copy(Self.FUrl, 0, Self.Furl.Length - 1);

  Self.FUrl := Self.FUrl + pEndpoint;
  Self.FUrl := TIdURI.URLEncode(Self.FUrl);

  pIdHttp.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko';
  pIdHttp.Request.ContentType := 'application/json';
  pIdHttp.HTTPOptions := pIdHttp.HTTPOptions + [hoNoProtocolErrorException];

  pIdHttp.Request.BasicAuthentication := (TManagerUser.Instance.LoggedUser.Login <> '') or (TManagerUser.Instance.LoggedUser.Password <> '');
  if pIdHttp.Request.BasicAuthentication then
  begin
    pIdHttp.Request.Username := TManagerUser.Instance.LoggedUser.Login;
    pIdHttp.Request.Password := TManagerUser.Instance.LoggedUser.Password;
  end;

  pIdHttp.URL.URI := Self.FUrl;
  Self.FHostname := pIdHttp.URL.Host;

  if pIdHttp.URL.Protocol = 'https' then
  begin
    with TIdSSLIOHandlerSocketOpenSSL(pIdHttp.IOHandler) do
    begin
      OnStatusInfoEx := Self.IdOnStatusInfoEx;
      SSLOptions.Method := sslvSSLv23;
      SSLOptions.Mode := sslmUnassigned;
    end;
  end;

  if Self.FRestConfig.ApiLogPath <> '' then
  begin
    try
      var logPath : String := IncludeTrailingPathDelimiter(Self.FRestConfig.ApiLogPath) + FormatDateTime('yyyy\yyyy-mm-dd\', Date());
      if not DirectoryExists(logPath) then
        ForceDirectories(logPath);

      pIdHttp.Intercept := TIdLogFile.Create(nil);
      TIdLogFile(pIdHttp.Intercept).ReplaceCRLF := False;
      TIdLogFile(pIdHttp.Intercept).Filename := logPath + FormatDateTime('yyyy-mm-dd__hh_nn_ss_zzz', Now()) + '_' + Self.ClassName + '.log';
      TIdLogFile(pIdHttp.Intercept).Active := True;
    except
      TIdLogFile(pIdHttp.Intercept).Active := False;
    end;
  end;
end;

procedure TRestClientApi.FreeIdHttp(pIdHttp: TIdHttp);
begin
  if not Assigned(pIdHttp) then
    Exit;

  if Assigned(pIdHttp.IOHandler) then
  begin
    pIdHttp.IOHandler.Free;
    pIdHttp.IOHandler := nil;
  end;

  if Assigned(pIdHttp.Intercept) then
  begin
    pIdHttp.Intercept.Free;
    pIdHttp.Intercept := nil;
  end;

  pIdHttp.Free;
end;

function TRestClientApi.GetCustomers(
  pCustomerList: TObjectList<TItemCustomer>): TApiResponse;
begin
  Result.ResponseCode := 0;

  if not Assigned(pCustomerList) then
  begin
    Result.ErrMsg := Self.ClassName + '.GetCustomers Error: user not assigned';
    Exit;
  end;

  pCustomerList.Clear;
  var idHttp := TIdHttp.Create(nil);
  try
    Self.PrepareIdHttp(idHttp, API_END_POINT_GET_CUSTOMERS);
  except
    on E: Exception do
    begin
      Self.FreeIdHttp(idHttp);
      E.Message := Self.ClassName + '.GetCustomers Error inside PrepareIdHttp:' + sLineBreak +
                   E.Message;

      Result.ErrMsg := E.Message;
    end;
  end;

  var outputStream : TStringStream := TStringStream.Create();
  try
    idHttp.Get(Self.FUrl, outputStream);
  except
    on E: Exception do
    begin
      Self.FreeIdHttp(idHttp);
      outputStream.Free;
      E.Message := Self.ClassName + '.GetCustomers Error inside idHttp.Get:' + sLineBreak +
                   E.Message;

      Result.ErrMsg := E.Message;
      Exit;
    end;
  end;

  var reqResult : ISuperObject := nil;
  try
    try
      reqResult := Self.GetResult(idHttp, outputStream);
    except
      on E: Exception do
      begin
        E.Message := Self.ClassName + '.GetCustomers Error inside GetResult:' + sLineBreak +
                     E.Message;

        Result.ErrMsg := E.Message;
        Exit;
      end;
    end;

    Result.ResponseCode := idHttp.ResponseCode;
  finally
    Self.FreeIdHttp(idHttp);
    outputStream.Free;
  end;

  var customerArrJson : TSuperArray := reqResult.AsArray;
  if not Assigned(customerArrJson) then
  begin
    Result.ResponseCode := 0;
    Result.ErrMsg := Self.ClassName + '.GetCustomers Error: request result array not assigned';
    Exit;
  end;

  for var I : Integer := 0 to customerArrJson.Length - 1 do
  begin
    var customerJSON : ISuperObject := customerArrJson.O[I];
    var customer : TItemCustomer := TItemCustomer.JsonToCustomer(customerJSON);

    if not Assigned(customer) then
      Continue;

    pCustomerList.Add(customer);
  end;
end;

function TRestClientApi.GetProducts(
  pProductList: TObjectList<TItemProduct>): TApiResponse;
begin
  Result.ResponseCode := 0;

  if not Assigned(pProductList) then
  begin
    Result.ErrMsg := Self.ClassName + '.GetProducts Error: user not assigned';
    Exit;
  end;

  pProductList.Clear;
  var idHttp := TIdHttp.Create(nil);
  try
    Self.PrepareIdHttp(idHttp, API_END_POINT_GET_PRODUCTS);
  except
    on E: Exception do
    begin
      Self.FreeIdHttp(idHttp);
      E.Message := Self.ClassName + '.GetProducts Error inside PrepareIdHttp:' + sLineBreak +
                   E.Message;

      Result.ErrMsg := E.Message;
    end;
  end;

  var outputStream : TStringStream := TStringStream.Create();
  try
    idHttp.Get(Self.FUrl, outputStream);
  except
    on E: Exception do
    begin
      Self.FreeIdHttp(idHttp);
      outputStream.Free;
      E.Message := Self.ClassName + '.GetProducts Error inside idHttp.Get:' + sLineBreak +
                   E.Message;

      Result.ErrMsg := E.Message;
      Exit;
    end;
  end;

  var reqResult : ISuperObject := nil;
  try
    try
      reqResult := Self.GetResult(idHttp, outputStream);
    except
      on E: Exception do
      begin
        E.Message := Self.ClassName + '.GetProducts Error inside GetResult:' + sLineBreak +
                     E.Message;

        Result.ErrMsg := E.Message;
        Exit;
      end;
    end;

    Result.ResponseCode := idHttp.ResponseCode;
  finally
    Self.FreeIdHttp(idHttp);
    outputStream.Free;
  end;

  var prodArrJson : TSuperArray := reqResult.AsArray;
  if not Assigned(prodArrJson) then
  begin
    Result.ResponseCode := 0;
    Result.ErrMsg := Self.ClassName + '.GetProducts Error: request result array not assigned';
    Exit;
  end;

  for var I : Integer := 0 to prodArrJson.Length - 1 do
  begin
    var prodJSON : ISuperObject := prodArrJson.O[I];
    var product : TItemProduct := TItemProduct.JsonToProduct(prodJSON);

    if not Assigned(product) then
      Continue;

    pProductList.Add(product);
  end;
end;

function TRestClientApi.GetResult(const pIdHttp: TIdHttp;
  const pOutputStream: TStringStream): ISuperObject;
begin
  if not Assigned(pIdHttp) then
    raise Exception.Create(Self.ClassName + '.GetResult: idHttp not assigned');

  if pIdHttp.ResponseCode <> HTTP_OK then
    raise Exception.Create(pIdHttp.ResponseText);

  var response : String := '';
  if Assigned(pOutputStream) then
    response := pOutputStream.DataString;

  response := UTF8ToWideString(response);
  Result := SO(response);
  if not (Assigned(Result) and (Result.DataType in [stObject, stArray])) then
  begin
    if pIdHttp.ResponseCode = HTTP_OK then
      raise Exception.Create('Request response is not valid JSON');

    raise Exception.Create(pIdHttp.ResponseText);
  end;
end;

function TRestClientApi.GetWeighingData(
  const pIdErpWeighing: Integer): TApiResponse;
begin

end;

function TRestClientApi.GetWeighings(pWeighingList: TObjectList<TItemWeighing>;
  const pSearchFilter: TSearchFilters): TApiResponse;
const
  jf_filter_date_start : String = 'date_start';
  jf_filter_date_stop : String = 'date_stop';
begin
  Result.ResponseCode := 0;

  if not Assigned(pWeighingList) then
  begin
    Result.ErrMsg := Self.ClassName + '.GetWeighings Error: user not assigned';
    Exit;
  end;

  pWeighingList.Clear;
  var idHttp := TIdHttp.Create(nil);
  try
    Self.PrepareIdHttp(idHttp, API_END_POINT_GET_WEIGHINGS);
  except
    on E: Exception do
    begin
      Self.FreeIdHttp(idHttp);
      E.Message := Self.ClassName + '.GetWeighings Error inside PrepareIdHttp:' + sLineBreak +
                   E.Message;

      Result.ErrMsg := E.Message;
    end;
  end;

  var iReqBody : ISuperObject := SO();
  iReqBody.DT[jf_filter_date_start] := pSearchFilter.DateStart;
  iReqBody.DT[jf_filter_date_stop] := pSearchFilter.DateStop;

  var inputStream : TStringStream := TStringStream.Create(iReqBody.AsJSon(True));
  var outputStream : TStringStream := TStringStream.Create();
  try
    idHttp.Post(Self.FUrl, inputStream, outputStream);
  except
    on E: Exception do
    begin
      Self.FreeIdHttp(idHttp);
      inputStream.Free;
      outputStream.Free;
      E.Message := Self.ClassName + '.GetWeighings Error inside idHttp.Get:' + sLineBreak +
                   E.Message;

      Result.ErrMsg := E.Message;
      Exit;
    end;
  end;

  var reqResult : ISuperObject := nil;
  try
    try
      reqResult := Self.GetResult(idHttp, outputStream);
    except
      on E: Exception do
      begin
        E.Message := Self.ClassName + '.GetWeighings Error inside GetResult:' + sLineBreak +
                     E.Message;

        Result.ErrMsg := E.Message;
        Exit;
      end;
    end;

    Result.ResponseCode := idHttp.ResponseCode;
  finally
    Self.FreeIdHttp(idHttp);
    inputStream.Free;
    outputStream.Free;
  end;

  var weighingArrJson : TSuperArray := reqResult.AsArray;
  if not Assigned(weighingArrJson) then
  begin
    Result.ResponseCode := 0;
    Result.ErrMsg := Self.ClassName + '.GetWeighings Error: request result array not assigned';
    Exit;
  end;

  for var I : Integer := 0 to weighingArrJson.Length - 1 do
  begin
    var weighingJSON : ISuperObject := weighingArrJson.O[I];
    var weighing : TItemWeighing := TItemWeighing.JsonToWeighing(weighingJSON);

    if not Assigned(weighing) then
      Continue;

    pWeighingList.Add(weighing);
  end;
end;

procedure TRestClientApi.IdOnStatusInfoEx(ASender: TObject;
  const AsslSocket: PSSL; const AWhere, Aret: Integer; const AType,
  AMsg: string);
begin
  SSL_set_tlsext_host_name(AsslSocket, Self.FHostname);
end;

function TRestClientApi.LogInUser(const pUser: TItemUser): TApiResponse;
begin
  Result.ResponseCode := 0;

  if not Assigned(pUser) then
  begin
    Result.ErrMsg := Self.ClassName + '.LogInUser Error: user not assigned';
    Exit;
  end;

  var idHttp := TIdHttp.Create(nil);
  try
    Self.PrepareIdHttp(idHttp, API_END_POINT_LOGIN);
  except
    on E: Exception do
    begin
      Self.FreeIdHttp(idHttp);
      E.Message := Self.ClassName + '.LogInUser Error inside PrepareIdHttp:' + sLineBreak +
                   E.Message;

      Result.ErrMsg := E.Message;
    end;
  end;

  idHttp.Request.BasicAuthentication := True;
  idHttp.Request.Username := pUser.Login;
  idHttp.Request.Password := pUser.Password;

  var outputStream : TStringStream := TStringStream.Create();
  try
    idHttp.Get(Self.FUrl, outputStream);
  except
    on E: Exception do
    begin
      Self.FreeIdHttp(idHttp);
      outputStream.Free;
      E.Message := Self.ClassName + '.LogInUser Error inside idHttp.Get:' + sLineBreak +
                   E.Message;

      Result.ErrMsg := E.Message;
      Exit;
    end;
  end;

  var reqResult : ISuperObject := nil;
  try
    try
      reqResult := Self.GetResult(idHttp, outputStream);
    except
      on E: Exception do
      begin
        E.Message := Self.ClassName + '.LogInUser Error inside GetResult:' + sLineBreak +
                     E.Message;

        Result.ErrMsg := E.Message;
        Exit;
      end;
    end;

    Result.ResponseCode := idHttp.ResponseCode;
  finally
    Self.FreeIdHttp(idHttp);
    outputStream.Free;
  end;
end;

function TRestClientApi.PostWeighing(
  const pWeighing: TItemWeighing): TApiResponse;
begin

end;

end.

unit cItemCustomer;

interface

uses
  cItemBase, cItemAddress, OverbyteIcsSuperObject, Uni;

type
  TItemCustomer = class(TItemBase)
    private
    const
    {$REGION 'JSON FIELDS'}
      jf_address : String = 'address';
      jf_name : String = 'name';
      jf_code : String = 'code';
      jf_nip : String = 'nip';
      jf_phone_no : String = 'phone_no';
    {$ENDREGION}
    private
      FAddress : TItemAddress;
      FName : String;
      FCode : String;
      FNIP : String;
      FPhoneNo : String;

      function GetAddress: TItemAddress;
      function GetName: String;
      procedure SetName(const Value: String);
      function GetCode: String;
      procedure SetCode(const Value: String);
      function GetNIP: String;
      procedure SetNIP(const Value: String);
      function GetPhoneNo: String;
      procedure SetPhoneNo(const Value: String);
      function GetFullName: String;
    public
      property Address: TItemAddress read GetAddress;
      property Name: String read GetName write SetName;
      property Code: String read GetCode write SetCode;
      property NIP: String read GetNIP write SetNIP;
      property PhoneNo: String read GetPhoneNo write SetPhoneNo;
      property FullName: String read GetFullName;

      procedure AssignValues(const pSource : TItemCustomer); reintroduce;
      procedure SetDefaultValues(); reintroduce;

      function ToJson() : ISuperObject; reintroduce;
      procedure FromJson(pCustomerJson : ISuperObject); reintroduce;

      procedure FromQuery(pCustomerQuery : TCustomUniDataSet; pIsWeighing : Boolean = False);

      class function JsonToCustomer(pCustomerJson : ISuperObject) : TItemCustomer;
      class function QueryToCustomer(pCustomerQuery : TCustomUniDataSet) : TItemCustomer;

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

uses
  System.SysUtils, cManagerAddresses;

{ TItemCustomer }

procedure TItemCustomer.AssignValues(const pSource: TItemCustomer);
begin
  if not Assigned(pSource) then
    Exit;

  inherited AssignValues(pSource);
  Self.Name := pSource.Name;
  Self.Code := pSource.Code;
  Self.NIP := pSource.NIP;
  Self.PhoneNo := pSource.PhoneNo;

  Self.Address.AssignValues(pSource.Address);
end;

constructor TItemCustomer.Create;
begin
  inherited;
  Self.FAddress := TItemAddress.Create;
  Self.SetDefaultValues;
end;

destructor TItemCustomer.Destroy;
begin
  Self.FAddress.Free;
  inherited;
end;

procedure TItemCustomer.FromJson(pCustomerJson: ISuperObject);
begin
  if not (Assigned(pCustomerJson) and (pCustomerJson.DataType = stObject)) then
    raise Exception.Create('wrong JSON format');

  Self.Name := pCustomerJson.S[jf_name];
  Self.Code := pCustomerJson.S[jf_code];
  Self.NIP := pCustomerJson.S[jf_nip];
  Self.PhoneNo := pCustomerJson.S[jf_phone_no];

  Self.Address.FromJson(pCustomerJson.O[jf_address]);

  inherited FromJson(pCustomerJson);
end;

procedure TItemCustomer.FromQuery(pCustomerQuery: TCustomUniDataSet;
  pIsWeighing : Boolean);
begin
  Self.Name := pCustomerQuery.FieldByName('CUST_NAME_OUT').AsString;
  Self.Code := pCustomerQuery.FieldByName('CUST_CODE_OUT').AsString;
  Self.NIP := pCustomerQuery.FieldByName('CUST_NIP_OUT').AsString;
  Self.PhoneNo := pCustomerQuery.FieldByName('CUST_PHONE_NO_OUT').AsString;
  Self.Id := pCustomerQuery.FieldByName('CUST_ID_OUT').AsInteger;
  Self.IdErp := Self.Id;
  //Self.LocationId := pCustomerQuery.FieldByName('').AsInteger;
  Self.ModificationDate := pCustomerQuery.FieldByName('CUST_MODIF_TIME_OUT').AsDateTime;
  Self.IsDeleted := pCustomerQuery.FieldByName('CUST_IS_DELETED_OUT').AsInteger <> 0;
  Self.IsModified := False;
  Self.Address.id := pCustomerQuery.FieldByName('CUST_ID_ADDRESS_OUT').AsInteger;

  var tmpAddress : TItemAddress := nil;
  try
    if not pIsWeighing then
      tmpAddress := TManagerAddresses.Instance.GetAddressFromDbById(Self.Address.id);
    if Assigned(tmpAddress) then
      Self.Address.AssignValues(tmpAddress);
  finally
    if Assigned(tmpAddress) then
      tmpAddress.Free;
  end;
end;

function TItemCustomer.GetAddress: TItemAddress;
begin
  Result := Self.FAddress;
end;

function TItemCustomer.GetCode: String;
begin
  Result := Self.FCode;
end;

function TItemCustomer.GetFullName: String;
begin
  Result := Self.Code;
  if not Result.IsEmpty then
    Result := Result + ' - ';

  Result := Result + Self.Name;
end;

function TItemCustomer.GetName: String;
begin
  Result := Self.FName;
end;

function TItemCustomer.GetNIP: String;
begin
  Result := Self.FNIP;
end;

function TItemCustomer.GetPhoneNo: String;
begin
  Result := Self.FPhoneNo;
end;

class function TItemCustomer.JsonToCustomer(
  pCustomerJson: ISuperObject): TItemCustomer;
begin
Result := nil;
  if not (Assigned(pCustomerJson) and (pCustomerJson.DataType = stObject)) then
    Exit;

  Result := TItemCustomer.Create;
  try
    Result.FromJson(pCustomerJson);
  except
    FreeAndNil(Result);
  end;
end;

class function TItemCustomer.QueryToCustomer(
  pCustomerQuery: TCustomUniDataSet): TItemCustomer;
begin
  Result := nil;
  if not Assigned(pCustomerQuery) then
    Exit;

  Result := TItemCustomer.Create;
  try
    Result.FromQuery(pCustomerQuery);
  except
    FreeAndNil(Result);
  end;
end;

procedure TItemCustomer.SetCode(const Value: String);
begin
  if Value <> Self.Code then
    Self.FCode := Value;
end;

procedure TItemCustomer.SetDefaultValues;
begin
  inherited;

  Self.Name := '';
  Self.NIP := '';
  Self.PhoneNo := '';

  Self.Address.SetDefaultValues;
end;

procedure TItemCustomer.SetName(const Value: String);
begin
  if Value <> Self.Name then
    Self.FName := Value;
end;

procedure TItemCustomer.SetNIP(const Value: String);
begin
  if Value <> Self.NIP then
    Self.FNIP := Value;
end;

procedure TItemCustomer.SetPhoneNo(const Value: String);
begin
  if Value <> Self.PhoneNo then
    Self.FPhoneNo := Value;
end;

function TItemCustomer.ToJson: ISuperObject;
begin
  Result := inherited ToJson();

  Result.S[jf_name] := Self.Name;
  Result.S[jf_code] := Self.Code;
  Result.S[jf_nip] := Self.NIP;
  Result.S[jf_phone_no] := Self.PhoneNo;
  Result.O[jf_address] := Self.Address.ToJson();
end;

end.

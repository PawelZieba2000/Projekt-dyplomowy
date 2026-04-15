unit cItemAddress;

interface

uses
  cItemBase, OverbyteIcsSuperObject, Uni;

type
  TItemAddress = class(TItemBase)
    private
    const
    {$REGION 'JSON FIELDS'}
      jf_street : String = 'street';
      jf_house_no : String = 'house_no';
      jf_local_no : String = 'local_no';
      jf_post_code : String = 'post_code';
      jf_city : String = 'city';
      jf_country : String = 'country';
    {$ENDREGION}
    private
      FStreet : String;
      FHouseNo : String;
      FLocalNo : String;
      FPostCode : String;
      FCity : String;
      FCountry : String;

      function GetStreet: String;
      procedure SetStreet(const Value: String);
      function GetHouseNo: String;
      procedure SetHouseNo(const Value: String);
      function GetLocalNo: String;
      procedure SetLocalNo(const Value: String);
      function GetPostCode: String;
      procedure SetPostCode(const Value: String);
      function GetCity: String;
      procedure SetCity(const Value: String);
      function GetCountry: String;
      procedure SetCountry(const Value: String);
    public
      property Street: String read GetStreet write SetStreet;
      property HouseNo: String read GetHouseNo write SetHouseNo;
      property LocalNo: String read GetLocalNo write SetLocalNo;
      property PostCode: String read GetPostCode write SetPostCode;
      property City: String read GetCity write SetCity;
      property Country: String read GetCountry write SetCountry;

      procedure AssignValues(const pSource : TItemAddress); reintroduce;
      procedure SetDefaultValues(); reintroduce;

      function ToJson() : ISuperObject; reintroduce;
      procedure FromJson(pAddressJson : ISuperObject); reintroduce;
      procedure FromQuery(pAddressQuery : TCustomUniDataSet);

      class function JsonToAddress(pAddressJson : ISuperObject) : TItemAddress;
      class function QueryToAddress(pAddressQuery : TCustomUniDataSet) : TItemAddress;

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

uses
  System.SysUtils;

{ TItemAddress }

procedure TItemAddress.AssignValues(const pSource: TItemAddress);
begin
  if not Assigned(pSource) then
    Exit;

  inherited AssignValues(pSource);
  Self.Street := pSource.Street;
  Self.HouseNo := pSource.HouseNo;
  Self.LocalNo := pSource.LocalNo;
  Self.PostCode := pSource.PostCode;
  Self.City := pSource.City;
  Self.Country := pSource.Country;
end;

constructor TItemAddress.Create;
begin
  inherited;

  Self.SetDefaultValues;
end;

destructor TItemAddress.Destroy;
begin
  inherited;
end;

procedure TItemAddress.FromJson(pAddressJson: ISuperObject);
begin
  if not (Assigned(pAddressJson) and (pAddressJson.DataType = stObject)) then
    raise Exception.Create('wrong JSON format');

  Self.Street := pAddressJson.S[jf_street];
  Self.HouseNo := pAddressJson.S[jf_house_no];
  Self.LocalNo := pAddressJson.S[jf_local_no];
  Self.PostCode := pAddressJson.S[jf_post_code];
  Self.City := pAddressJson.S[jf_city];
  Self.Country := pAddressJson.S[jf_country];

  inherited FromJson(pAddressJson);
end;

procedure TItemAddress.FromQuery(pAddressQuery: TCustomUniDataSet);
begin
  Self.Street := pAddressQuery.FieldByName('ADDRESS_STREET_OUT').AsString;
  Self.HouseNo := pAddressQuery.FieldByName('ADDRESS_HOUSE_NO_OUT').AsString;
  Self.LocalNo := pAddressQuery.FieldByName('ADDRESS_LOCAL_NO_OUT').AsString;
  Self.PostCode := pAddressQuery.FieldByName('ADDRESS_POST_CODE_OUT').AsString;
  Self.City := pAddressQuery.FieldByName('ADDRESS_CITY_OUT').AsString;
  Self.Country := pAddressQuery.FieldByName('ADDRESS_COUNTRY_OUT').AsString;
  Self.Id := pAddressQuery.FieldByName('ADDRESS_ID_OUT').AsInteger;
  Self.IdErp := Self.Id;
  Self.ModificationDate := pAddressQuery.FieldByName('ADDRESS_MODIF_TIME_OUT').AsDateTime;
  Self.IsDeleted := pAddressQuery.FieldByName('ADDRESS_IS_DELETED_OUT').AsInteger <> 0;
  Self.IsModified := False;
end;

function TItemAddress.GetCity: String;
begin
  Result := Self.FCity;
end;

function TItemAddress.GetCountry: String;
begin
  Result := Self.FCountry;
end;

function TItemAddress.GetHouseNo: String;
begin
  Result := Self.FHouseNo;
end;

function TItemAddress.GetLocalNo: String;
begin
  Result := Self.FLocalNo;
end;

function TItemAddress.GetPostCode: String;
begin
  Result := Self.FPostCode;
end;

function TItemAddress.GetStreet: String;
begin
  Result := Self.FStreet;
end;

class function TItemAddress.JsonToAddress(
  pAddressJson: ISuperObject): TItemAddress;
begin
  Result := nil;
  if not (Assigned(pAddressJson) and (pAddressJson.DataType = stObject)) then
    Exit;

  Result := TItemAddress.Create;
  try
    Result.FromJson(pAddressJson);
  except
    FreeAndNil(Result);
  end;
end;

class function TItemAddress.QueryToAddress(
  pAddressQuery: TCustomUniDataSet): TItemAddress;
begin
  Result := nil;
  if not Assigned(pAddressQuery) then
    Exit;

  Result := TItemAddress.Create;
  try
    Result.FromQuery(pAddressQuery);
  except
    FreeAndNil(Result);
  end;
end;

procedure TItemAddress.SetCity(const Value: String);
begin
  if Value <> Self.City then
    Self.FCity := Value;
end;

procedure TItemAddress.SetCountry(const Value: String);
begin
  if Value <> Self.Country then
    Self.FCountry := Value;
end;

procedure TItemAddress.SetDefaultValues;
begin
  inherited;
  Self.Street := '';
  Self.HouseNo := '';
  Self.LocalNo := '';
  Self.PostCode := '';
  Self.City := '';
  Self.Country := '';
end;

procedure TItemAddress.SetHouseNo(const Value: String);
begin
  if Value <> Self.HouseNo then
    Self.FHouseNo := Value;
end;

procedure TItemAddress.SetLocalNo(const Value: String);
begin
  if Value <> Self.LocalNo then
    Self.FLocalNo := Value;
end;

procedure TItemAddress.SetPostCode(const Value: String);
begin
  if Value <> Self.PostCode then
    Self.FPostCode := Value;
end;

procedure TItemAddress.SetStreet(const Value: String);
begin
  if Value <> Self.Street then
    Self.FStreet := Value;
end;

function TItemAddress.ToJson: ISuperObject;
begin
  Result := inherited ToJson();

  Result.S[jf_street] := Self.Street;
  Result.S[jf_house_no] := Self.HouseNo;
  Result.S[jf_local_no] := Self.LocalNo;
  Result.S[jf_post_code] := Self.PostCode;
  Result.S[jf_city] := Self.City;
  Result.S[jf_country] := Self.Country;
end;

end.

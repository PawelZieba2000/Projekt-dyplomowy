unit cItemWeighing;

interface

uses
  OverbyteIcsSuperObject, cItemBase, cItemProduct, cItemCustomer, cItemUser,
  cTypes, Uni;

type
  TItemWeighing = class(TItemBase)
    private
    const
    {$REGION 'JSON FIELDS'}
        jf_customer : String = 'customer';
        jf_product : String = 'product';
        jf_user_in_id : String = 'user_in_id';
        jf_user_out_id : String = 'user_out_id';
        jf_user_in_fname : String = 'user_in_fname';
        jf_user_out_fname : String = 'user_out_fname';
        jf_user_in_lname : String = 'user_in_lname';
        jf_user_out_lname : String = 'user_out_lname';
        jf_weighing_no : String = 'weighing_no';
        jf_mass_in : String = 'mass_in';
        jf_mass_out : String = 'mass_out';
        jf_mass_netto : String = 'mass_netto';
        jf_mass_tare : String = 'mass_tare';
        jf_date_in : String = 'date_in';
        jf_date_out : String = 'date_out';
        jf_car_no : String = 'car_no';
        jf_trailer_no : String = 'trailer_no';
        jf_weighing_type : String = 'weighing_type';
      {$ENDREGION}
    private
      FCustomer : TItemCustomer;
      FProduct : TItemProduct;
      FUserIn : TItemUser;
      FUserOut : TItemUser;

      FWeighingNo : String;

      FMassIn : Double;
      FMassOut : Double;

      FDateIn : TDateTime;
      FDateOut : TDateTime;

      FCarNo : String;
      FTrailerNo : String;

      FWeighingType : TWeighingType;

      function GetCustomer: TItemCustomer;
      function GetProduct: TItemProduct;
      function GetUserIn: TItemUser;
      function GetUserOut: TItemUser;

      function GetMassIn: Double;
      procedure SetMassIn(const Value: Double);
      function GetMassOut: Double;
      procedure SetMassOut(const Value: Double);
      function GetDateIn: TDateTime;
      procedure SetDateIn(const Value: TDateTime);
      function GetDateOut: TDateTime;
      procedure SetDateOut(const Value: TDateTime);
      function GetCarNo: String;
      procedure SetCarNo(const Value: String);
      function GetTrailerNo: String;
      procedure SetTrailerNo(const Value: String);
      function GetMassNetto: Double;
      function GetMassTare: Double;
      function GetWeighingType: TWeighingType;
      procedure SetWeighingType(const Value: TWeighingType);
      function GetWeighingNo: String;
      procedure SetWeighingNo(const Value: String);
    public
      property Customer: TItemCustomer read GetCustomer;
      property Product: TItemProduct read GetProduct;
      property UserIn: TItemUser read GetUserIn;
      property UserOut: TItemUser read GetUserOut;

      property WeighingNo: String read GetWeighingNo write SetWeighingNo;
      property MassIn: Double read GetMassIn write SetMassIn;
      property MassOut: Double read GetMassOut write SetMassOut;
      property MassNetto: Double read GetMassNetto;
      property MassTare: Double read GetMassTare;

      property DateIn: TDateTime read GetDateIn write SetDateIn;
      property DateOut: TDateTime read GetDateOut write SetDateOut;

      property CarNo: String read GetCarNo write SetCarNo;
      property TrailerNo: String read GetTrailerNo write SetTrailerNo;

      property WeighingType: TWeighingType read GetWeighingType write SetWeighingType;

      procedure SetDefaultValues(); reintroduce;

      function ToJson() : ISuperObject; reintroduce;
      procedure FromJson(pWeighingJson : ISuperObject); reintroduce;
      procedure FromQuery(pWeighingQuery : TCustomUniDataSet);

      class function JsonToWeighing(pWeighingJson : ISuperObject) : TItemWeighing;
      class function QueryToWeighing(pWeighingQuery : TCustomUniDataSet) : TItemWeighing;

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

uses
  System.SysUtils;

{ TItemWeighing }

constructor TItemWeighing.Create;
begin
  inherited Create();

  Self.FCustomer := TItemCustomer.Create;
  Self.FProduct := TItemProduct.Create;
  Self.FUserIn := TItemUser.Create;
  Self.FUserOut := TItemUser.Create;
end;

destructor TItemWeighing.Destroy;
begin
  Self.FCustomer.Free;
  Self.FProduct.Free;
  Self.FUserIn.Free;
  Self.FUserOut.Free;

  inherited;
end;

procedure TItemWeighing.FromJson(pWeighingJson: ISuperObject);
begin
  if not (Assigned(pWeighingJson) and (pWeighingJson.DataType = stObject)) then
    raise Exception.Create('wrong JSON format');

  Self.WeighingNo := pWeighingJson.S[jf_weighing_no];
  Self.MassIn := pWeighingJson.D[jf_mass_in];
  Self.MassOut := pWeighingJson.D[jf_mass_out];
  Self.DateIn := pWeighingJson.DT[jf_date_in];
  Self.DateOut := pWeighingJson.DT[jf_date_out];
  Self.CarNo := pWeighingJson.S[jf_car_no];
  Self.TrailerNo := pWeighingJson.S[jf_trailer_no];
  Self.WeighingType := TWeighingType.FromInteger(pWeighingJson.I[jf_weighing_type]);
  Self.UserIn.Id := pWeighingJson.I[jf_user_in_id];
  Self.UserIn.FirstName := pWeighingJson.S[jf_user_in_fname];
  Self.UserIn.LastName := pWeighingJson.S[jf_user_in_lname];
  Self.UserOut.Id := pWeighingJson.I[jf_user_out_id];
  Self.UserOut.FirstName := pWeighingJson.S[jf_user_out_fname];
  Self.UserOut.LastName := pWeighingJson.S[jf_user_out_lname];

  Self.Customer.FromJson(pWeighingJson.O[jf_customer]);
  Self.Product.FromJson(pWeighingJson.O[jf_product]);

  inherited FromJson(pWeighingJson);
end;

procedure TItemWeighing.FromQuery(pWeighingQuery: TCustomUniDataSet);
begin
  Self.IdErp := pWeighingQuery.FieldByName('ID_OUT').AsInteger;
  Self.WeighingNo := pWeighingQuery.FieldByName('WEIGHING_NO_OUT').AsString;
  Self.MassIn := pWeighingQuery.FieldByName('MASS_IN_OUT').AsFloat;
  Self.MassOut := pWeighingQuery.FieldByName('MASS_OUT_OUT').AsFloat;
  Self.DateIn := pWeighingQuery.FieldByName('DATE_IN_OUT').AsDateTime;
  Self.DateOut := pWeighingQuery.FieldByName('DATE_OUT_OUT').AsDateTime;
  Self.CarNo := pWeighingQuery.FieldByName('CAR_NO_OUT').AsString;
  Self.TrailerNo := pWeighingQuery.FieldByName('TRAILER_NO_OUT').AsString;
  Self.UserIn.Id := pWeighingQuery.FieldByName('ID_USER_IN_OUT').AsInteger;
  Self.UserOut.Id := pWeighingQuery.FieldByName('ID_USER_OUT_OUT').AsInteger;

  Self.Product.FromQuery(pWeighingQuery);
  Self.Customer.FromQuery(pWeighingQuery, True);
  Self.Customer.Address.FromQuery(pWeighingQuery);
end;

function TItemWeighing.GetCarNo: String;
begin
  Result := Self.FCarNo;
end;

function TItemWeighing.GetCustomer: TItemCustomer;
begin
  Result := Self.FCustomer;
end;

function TItemWeighing.GetDateIn: TDateTime;
begin
  Result := Self.FDateIn;
end;

function TItemWeighing.GetDateOut: TDateTime;
begin
  Result := Self.FDateOut;
end;

function TItemWeighing.GetMassIn: Double;
begin
  Result := Self.FMassIn;
end;

function TItemWeighing.GetMassNetto: Double;
begin
  Result := Abs(Self.MassIn - Self.MassOut);
end;

function TItemWeighing.GetMassOut: Double;
begin
  Result := Self.FMassOut;
end;

function TItemWeighing.GetMassTare: Double;
begin
  Result := Self.MassIn;
end;

function TItemWeighing.GetProduct: TItemProduct;
begin
  Result := Self.FProduct;
end;

function TItemWeighing.GetTrailerNo: String;
begin
  Result := Self.FTrailerNo;
end;

function TItemWeighing.GetUserIn: TItemUser;
begin
  Result := Self.FUserIn;
end;

function TItemWeighing.GetUserOut: TItemUser;
begin
  Result := Self.FUserOut
end;

function TItemWeighing.GetWeighingNo: String;
begin
  Result := Self.FWeighingNo;
end;

function TItemWeighing.GetWeighingType: TWeighingType;
begin
  Result := Self.FWeighingType;
end;

class function TItemWeighing.JsonToWeighing(
  pWeighingJson: ISuperObject): TItemWeighing;
begin
  Result := nil;
  if not (Assigned(pWeighingJson) and (pWeighingJson.DataType = stObject)) then
    Exit;

  Result := TItemWeighing.Create;
  try
    Result.FromJson(pWeighingJson);
  except
    FreeAndNil(Result);
  end;
end;

class function TItemWeighing.QueryToWeighing(
  pWeighingQuery: TCustomUniDataSet): TItemWeighing;
begin
  Result := nil;
  if not Assigned(pWeighingQuery) then
    Exit;

  Result := TItemWeighing.Create;
  try
    Result.FromQuery(pWeighingQuery);
  except
    FreeAndNil(Result);
  end;
end;

procedure TItemWeighing.SetCarNo(const Value: String);
begin
  if Value <> Self.CarNo then
    Self.FCarNo := Value;
end;

procedure TItemWeighing.SetDateIn(const Value: TDateTime);
begin
  if Value <> Self.DateIn then
    Self.FDateIn := Value;
end;

procedure TItemWeighing.SetDateOut(const Value: TDateTime);
begin
  if Value <> Self.DateOut then
    Self.FDateOut := Value;
end;

procedure TItemWeighing.SetDefaultValues;
begin
  inherited;

  Self.Customer.SetDefaultValues();
  Self.Product.SetDefaultValues();
  Self.UserIn.SetDefaultValues();
  Self.UserOut.SetDefaultValues();

  Self.MassIn := 0;
  Self.MassOut := 0;

  Self.DateIn := MinDateTime;
  Self.DateOut := MinDateTime;

  Self.CarNo := '';
  Self.TrailerNo := '';
end;

procedure TItemWeighing.SetMassIn(const Value: Double);
begin
  if Value <> Self.MassIn then
    Self.FMassIn := Value;
end;

procedure TItemWeighing.SetMassOut(const Value: Double);
begin
  if Value <> Self.MassOut then
    Self.FMassOut := Value;
end;

procedure TItemWeighing.SetTrailerNo(const Value: String);
begin
  if Value <> Self.TrailerNo then
    Self.FTrailerNo := Value;
end;

procedure TItemWeighing.SetWeighingNo(const Value: String);
begin
  if Value <> Self.WeighingNo then
    Self.FWeighingNo := Value;
end;

procedure TItemWeighing.SetWeighingType(const Value: TWeighingType);
begin
  if Value <> Self.WeighingType then
    Self.FWeighingType := Value;
end;

function TItemWeighing.ToJson: ISuperObject;
begin
  Result := inherited ToJson();

  Result.O[jf_customer] := Self.Customer.ToJson();
  Result.O[jf_product] := Self.Product.ToJson();
  Result.I[jf_user_in_id] := Self.UserIn.Id;
  Result.I[jf_user_out_id] := Self.UserOut.Id;

  Result.S[jf_weighing_no] := Self.WeighingNo;
  Result.D[jf_mass_in] := Self.MassIn;
  Result.D[jf_mass_out] := Self.MassOut;
  Result.D[jf_mass_netto] := Self.MassNetto;
  Result.D[jf_mass_tare] := Self.MassTare;
  Result.DT[jf_date_in] := Self.DateIn;
  Result.DT[jf_date_out] := Self.DateOut;
  Result.S[jf_car_no] := Self.CarNo;
  Result.S[jf_trailer_no] := Self.TrailerNo;
  Result.I[jf_weighing_type] := Self.WeighingType.ToInteger;
end;

end.

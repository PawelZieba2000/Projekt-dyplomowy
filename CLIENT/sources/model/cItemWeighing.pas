unit cItemWeighing;

interface

uses
  OverbyteIcsSuperObject, cItemBase, cItemProduct, cItemCustomer, cItemUser,
  cTypes;

type
  TItemWeighing = class(TItemBase)
    private
    const
    {$REGION 'JSON FIELDS'}
        jf_customer : String = 'customer';
        jf_product : String = 'product';
        jf_user_id : String = 'user_id';
        jf_mass_in : String = 'mass_in';
        jf_mass_out : String = 'mass_out';
        jf_mass_netto : String = 'mass_netto';
        jf_mass_tare : String = 'mass_tare';
        jf_date_in : String = 'date_in';
        jf_date_out : String = 'date_out';
        jf_car_no : String = 'car_no';
        jf_trailer_no : String = 'trailer_no';
      {$ENDREGION}
    private
      FCustomer : TItemCustomer;
      FProduct : TItemProduct;
      FUser : TItemUser;

      FMassIn : Double;
      FMassOut : Double;

      FDateIn : TDateTime;
      FDateOut : TDateTime;

      FCarNo : String;
      FTrailerNo : String;

      FWeighingType : TWeighingType;

      function GetCustomer: TItemCustomer;
      function GetProduct: TItemProduct;
      function GetUser: TItemUser;

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
    public
      property Customer: TItemCustomer read GetCustomer;
      property Product: TItemProduct read GetProduct;
      property User: TItemUser read GetUser;

      property MassIn: Double read GetMassIn write SetMassIn;
      property MassOut: Double read GetMassOut write SetMassOut;
      property MassNetto: Double read GetMassNetto;
      property MassTare: Double read GetMassTare;

      property DateIn: TDateTime read GetDateIn write SetDateIn;
      property DateOut: TDateTime read GetDateOut write SetDateOut;

      property CarNo: String read GetCarNo write SetCarNo;
      property TrailerNo: String read GetTrailerNo write SetTrailerNo;

      property WeighingType: TWeighingType read GetWeighingType write SetWeighingType;

      procedure SetDefaultValues(); override;

      function ToJson() : ISuperObject; reintroduce;
      procedure FromJson(pWeighingJson : ISuperObject); reintroduce;

      class function JsonToWeighing(pWeighingJson : ISuperObject) : TItemWeighing;

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
  Self.FUser := TItemUser.Create;
end;

destructor TItemWeighing.Destroy;
begin
  Self.FCustomer.Free;
  Self.FProduct.Free;
  Self.FUser.Free;

  inherited;
end;

procedure TItemWeighing.FromJson(pWeighingJson: ISuperObject);
begin
  if not (Assigned(pWeighingJson) and (pWeighingJson.DataType = stObject)) then
    raise Exception.Create('wrong JSON format');

  Self.MassIn := pWeighingJson.D[jf_mass_in];
  Self.MassOut := pWeighingJson.D[jf_mass_out];
  Self.DateIn := pWeighingJson.DT[jf_date_in];
  Self.DateOut := pWeighingJson.DT[jf_date_out];
  Self.CarNo := pWeighingJson.S[jf_car_no];
  Self.TrailerNo := pWeighingJson.S[jf_trailer_no];
  Self.User.Id := pWeighingJson.I[jf_user_id];

  Self.Customer.FromJson(pWeighingJson.O[jf_customer]);
  Self.Product.FromJson(pWeighingJson.O[jf_product]);

  inherited FromJson(pWeighingJson);
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

function TItemWeighing.GetUser: TItemUser;
begin
  Result := Self.FUser;
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
  Self.User.SetDefaultValues();

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
  Result.I[jf_user_id] := Self.User.Id;

  Result.D[jf_mass_in] := Self.MassIn;
  Result.D[jf_mass_out] := Self.MassOut;
  Result.D[jf_mass_netto] := Self.MassNetto;
  Result.D[jf_mass_tare] := Self.MassTare;
  Result.DT[jf_date_in] := Self.DateIn;
  Result.DT[jf_date_out] := Self.DateOut;
  Result.S[jf_car_no] := Self.CarNo;
  Result.S[jf_trailer_no] := Self.TrailerNo;
end;

end.

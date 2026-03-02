unit cItemProduct;

interface

uses
  cItemBase, OverbyteIcsSuperObject, Uni;

type
  TItemProduct = class(TItemBase)
    private
    const
    {$REGION 'JSON FIELDS'}
      jf_name : String = 'name';
      jf_code : String = 'code';
      jf_price : String = 'price';
    {$ENDREGION}
    private
      FName : String;
      FCode : String;
      FPrice : Currency;

      function GetName: String;
      procedure SetName(const Value: String);
      function GetCode: String;
      procedure SetCode(const Value: String);
      function GetPrice: Currency;
      procedure SetPrice(const Value: Currency);
      function GetFullName: String;
    public
      property Name: String read GetName write SetName;
      property Code: String read GetCode write SetCode;
      property Price: Currency read GetPrice write SetPrice;
      property FullName: String read GetFullName;

      procedure AssignValues(const pSource : TItemProduct); reintroduce;
      procedure SetDefaultValues(); reintroduce;

      function ToJson() : ISuperObject; reintroduce;
      procedure FromJson(pProdJson : ISuperObject); reintroduce;

      procedure FromQuery(pProdQuery : TCustomUniDataSet);

      class function JsonToProduct(pProdJson : ISuperObject) : TItemProduct;
      class function QueryToProduct(pProdQuery : TCustomUniDataSet) : TItemProduct;

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

uses
  System.SysUtils;

{ TItemProduct }

procedure TItemProduct.AssignValues(const pSource: TItemProduct);
begin
  if not Assigned(pSource) then
    Exit;

  inherited AssignValues(pSource);
  Self.Name := pSource.Name;
  Self.Code := pSource.Code;
  Self.Price := pSource.Price;
end;

constructor TItemProduct.Create;
begin
  inherited;

  Self.SetDefaultValues;
end;

destructor TItemProduct.Destroy;
begin
  inherited;
end;

procedure TItemProduct.FromJson(pProdJson: ISuperObject);
begin
  if not (Assigned(pProdJson) and (pProdJson.DataType = stObject)) then
    raise Exception.Create('wrong JSON format');

  Self.Name := pProdJson.S[jf_name];
  Self.Code := pProdJson.S[jf_code];
  Self.Price := pProdJson.D[jf_price];

  inherited FromJson(pProdJson);
end;

procedure TItemProduct.FromQuery(pProdQuery: TCustomUniDataSet);
begin
  Self.Name := pProdQuery.FieldByName('NAME_OUT').AsString;
  Self.Code := pProdQuery.FieldByName('CODE_OUT').AsString;
  Self.Price := pProdQuery.FieldByName('PRICE_OUT').AsFloat;
  Self.Id := pProdQuery.FieldByName('ID_OUT').AsInteger;
  Self.LocationId := pProdQuery.FieldByName('').AsInteger;
end;

class function TItemProduct.JsonToProduct(pProdJson: ISuperObject): TItemProduct;
begin
  Result := nil;
  if not (Assigned(pProdJson) and (pProdJson.DataType = stObject)) then
    Exit;

  Result := TItemProduct.Create;
  try
    Result.FromJson(pProdJson);
  except
    FreeAndNil(Result);
  end;
end;

class function TItemProduct.QueryToProduct(
  pProdQuery: TCustomUniDataSet): TItemProduct;
begin
  Result := nil;
  if not Assigned(pProdQuery) then
    Exit;

  Result := TItemProduct.Create;
  try
    Result.FromQuery(pProdQuery);
  except
    FreeAndNil(Result);
  end;
end;

function TItemProduct.GetCode: String;
begin
  Result := Self.FCode;
end;

function TItemProduct.GetFullName: String;
begin
  Result := Self.Code;
  if not Result.IsEmpty then
    Result := Result + ' - ';

  Result := Result + Self.Name;
end;

function TItemProduct.GetName: String;
begin
  Result := Self.FName;
end;

function TItemProduct.GetPrice: Currency;
begin
  Result := Self.FPrice;
end;

procedure TItemProduct.SetCode(const Value: String);
begin
  if Value <> Self.Code then
    Self.FCode := Value;
end;

procedure TItemProduct.SetDefaultValues;
begin
  inherited;

  Self.Name := '';
  Self.Code := '';
  Self.Price := 0;
end;

procedure TItemProduct.SetName(const Value: String);
begin
  if Value <> Self.Name then
    Self.FName := Value;
end;

procedure TItemProduct.SetPrice(const Value: Currency);
begin
  if Value <> Self.Price then
    Self.FPrice := Value;
end;

function TItemProduct.ToJson: ISuperObject;
begin
  Result := inherited ToJson();

  Result.S[jf_name] := Self.Name;
  Result.S[jf_code] := Self.Code;
  Result.D[jf_price] := Self.Price;
end;

end.

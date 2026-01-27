unit cItemProduct;

interface

uses
  cItemBase, OverbyteIcsSuperObject;

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
    public
      property Name: String read GetName write SetName;
      property Code: String read GetCode write SetCode;
      property Price: Currency read GetPrice write SetPrice;

      procedure AssignValues(const pSource : TItemProduct); reintroduce;
      procedure SetDefaultValues(); override;

      function ToJson() : ISuperObject; reintroduce;

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

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

function TItemProduct.GetCode: String;
begin
  Result := Self.FCode;
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

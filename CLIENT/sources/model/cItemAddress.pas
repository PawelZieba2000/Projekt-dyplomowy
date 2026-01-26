unit cItemAddress;

interface

uses
  cItemBase;

type
  TItemAddress = class(TItemBase)
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

      procedure SetDefaultValues(); override;

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

{ TItemAddress }

constructor TItemAddress.Create;
begin
  inherited;

  Self.SetDefaultValues;
end;

destructor TItemAddress.Destroy;
begin
  inherited;
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

end.

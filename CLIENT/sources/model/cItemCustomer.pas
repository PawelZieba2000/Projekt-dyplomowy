unit cItemCustomer;

interface

uses
  cItemBase, cItemAddress;

type
  TItemCustomer = class(TItemBase)
    private
      FAddress : TItemAddress;
      FName : String;
      FNIP : String;
      FPhoneNo : String;

      function GetAddress: TItemAddress;
      function GetName: String;
      procedure SetName(const Value: String);
      function GetNIP: String;
      procedure SetNIP(const Value: String);
      function GetPhoneNo: String;
      procedure SetPhoneNo(const Value: String);
    public
      property Address: TItemAddress read GetAddress;
      property Name: String read GetName write SetName;
      property NIP: String read GetNIP write SetNIP;
      property PhoneNo: String read GetPhoneNo write SetPhoneNo;

      procedure SetDefaultValues(); override;

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

{ TItemCustomer }

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

function TItemCustomer.GetAddress: TItemAddress;
begin
  Result := Self.FAddress;
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

end.

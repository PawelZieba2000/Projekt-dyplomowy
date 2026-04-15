unit cManagerCustomers;

interface

uses
  cItemCustomer, System.Generics.Collections, cDataSourceCustomers;

type
  TManagerCustomers = class
    private
      FCustomerList : TObjectList<TItemCustomer>;
      FCustomersDS : TDataSourceCustomers;

      class var FInstance : TManagerCustomers;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property CustomerList : TObjectList<TItemCustomer> read FCustomerList;
      property CustomersDS : TDataSourceCustomers read FCustomersDS;

      procedure GetCustomers();

      constructor Create(); overload;
      class function Instance : TManagerCustomers;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils, cManagerApiService;

{ TManagerCustomers }

constructor TManagerCustomers.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TManagerCustomers.CreateInstance;
begin
  inherited Create;

  Self.FCustomerList := TObjectList<TItemCustomer>.Create();
  Self.FCustomersDS := TDataSourceCustomers.Create(Self.FCustomerList);
end;

destructor TManagerCustomers.Destroy;
begin
  Self.FCustomerList.Free;
  Self.FCustomersDS.Free;

  inherited;
end;

procedure TManagerCustomers.GetCustomers;
begin
  TManagerApiService.Instance.GetCustomers(Self.FCustomerList);
end;

class function TManagerCustomers.Instance: TManagerCustomers;
begin
  if not Assigned(FInstance) then
    FInstance := TManagerCustomers.CreateInstance;

  Result := FInstance;
end;

class procedure TManagerCustomers.ReleaseInstance;
begin
  FInstance.Free;
end;

end.

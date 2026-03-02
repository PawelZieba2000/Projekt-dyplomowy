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

      procedure GetCustomersFromDb();
      procedure InsertUpdateCustomer(pCustomer: TItemCustomer);

      constructor Create(); overload;
      class function Instance : TManagerCustomers;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils, uModDatabase, cManagerUser, Uni;

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

procedure TManagerCustomers.GetCustomersFromDb;
begin
  Self.FCustomerList.Clear;

  if not ModuleDataBase.connDatabase.Connected then
    raise Exception.Create('Database is not connected');

  var sql : String := 'SELECT * FROM GET_CUSTOMERS(:ID_IN, :ID_LOCATION_IN) ';
  var query : TUniQuery := TUniQuery.Create(nil);
  try
    try
      ModuleDataBase.PrepareQuery(query, sql);
      query.ParamByName('ID_IN').Value := 0;
      query.ParamByName('ID_LOCATION_IN').Value := 0;

      query.Open;
      query.First;

      while not query.Eof do
      begin
        var tmpCustomer : TItemCustomer := TItemCustomer.QueryToCustomer(query);
        if Assigned(tmpCustomer) then
          Self.FCustomerList.Add(tmpCustomer);

        query.Next;
      end;
    except
      on E: Exception do
      begin
        E.Message := 'Error in ' + Self.ClassName + '.GetCustomersFromDb():' + sLineBreak +
                     E.Message;
        raise;
      end;
    end;
  finally
    if query.Active then
      query.Close;
    query.Free;
  end;
end;

procedure TManagerCustomers.InsertUpdateCustomer(pCustomer: TItemCustomer);
begin
  if not ModuleDataBase.connDatabase.Connected then
    raise Exception.Create('Database is not connected');

  if not Assigned(pCustomer) then
    raise Exception.Create('Customer not assigned');

  var transaction : TUniTransaction := TUniTransaction.Create(nil);
  var storedProc : TUniStoredProc := TUniStoredProc.Create(nil);
  try
    try
      ModuleDataBase.PrepareStoredProcedure(storedProc, 'INSERT_UPDATE_CUSTOMER', transaction);

      storedProc.ParamByName('ID_IN').Value := pCustomer.Id;
      storedProc.ParamByName('CODE_IN').Value := pCustomer.Code;
      storedProc.ParamByName('NAME_IN').Value := pCustomer.Name;
      storedProc.ParamByName('NIP_IN').Value := pCustomer.NIP;
      storedProc.ParamByName('PHONE_NO_IN').Value := pCustomer.PhoneNo;
      storedProc.ParamByName('ID_ADDRESS_IN').Value := pCustomer.Address.Id;
      storedProc.ParamByName('IS_DELETED_IN').Value := pCustomer.IsDeleted;
      storedProc.ParamByName('ID_USER_IN').Value := TManagerUser.Instance.LoggedUser.Id;

      storedProc.ExecProc;

      pCustomer.Id := storedProc.FieldByName('ID_OUT').AsInteger;

      transaction.Commit;
    except
      on E: Exception do
      begin
        if transaction.Active then
          transaction.Rollback;

        E.Message := 'Error in ' + Self.ClassName + '.InsertUpdateCustomer():' + sLineBreak +
                     E.Message;
        raise;
      end;
    end;
  finally
    transaction.Free;
    storedProc.Free;
  end;
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

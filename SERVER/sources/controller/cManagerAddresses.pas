unit cManagerAddresses;

interface

uses
  cItemAddress, System.Generics.Collections, cDataSourceCustomers;

type
  TManagerAddresses = class
    private
      FAddressesList : TObjectList<TItemAddress>;
      FAddressesDS : TDataSourceCustomers;

      class var FInstance : TManagerAddresses;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property AddressesList : TObjectList<TItemAddress> read FAddressesList;
      property AddressesDS : TDataSourceCustomers read FAddressesDS;

      function GetAddressFromDbById(pAddressId : Integer) : TItemAddress;
      procedure InsertUpdateAddress(pAddress: TItemAddress);

      constructor Create(); overload;
      class function Instance : TManagerAddresses;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils, uModDatabase, cManagerUser, Uni;

{ TManagerAddresses }

constructor TManagerAddresses.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TManagerAddresses.CreateInstance;
begin
  inherited Create;

  Self.FAddressesList := TObjectList<TItemAddress>.Create();
//  Self.FAddressesDS := TDataSourceCustomers.Create(Self.FAddressesList);
end;

destructor TManagerAddresses.Destroy;
begin
  Self.FAddressesList.Free;
//  Self.FAddressesDS.Free;

  inherited;
end;

function TManagerAddresses.GetAddressFromDbById(
  pAddressId : Integer) : TItemAddress;
begin
  Result := nil;

  if not ModuleDataBase.connDatabase.Connected then
    raise Exception.Create('Database is not connected');

  var sql : String := 'SELECT * FROM GET_ADDRESSES(:ID_IN)';
  var query : TUniQuery := TUniQuery.Create(nil);
  try
    try
      ModuleDataBase.PrepareQuery(query, sql);
      query.ParamByName('ID_IN').Value := pAddressId;

      query.Open;
      query.First;

      if query.Eof then
        Exit;

      if query.FieldByName('ADDRESS_ID_OUT').IsNull or (query.FieldByName('ADDRESS_ID_OUT').Value = 0) then
        raise Exception.Create('There is no address with id ' + pAddressId.ToString);

      Result := TItemAddress.QueryToAddress(query);
    except
      on E: Exception do
      begin
        E.Message := 'Error in ' + Self.ClassName + '.GetAddressFromDbById():' + sLineBreak +
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

procedure TManagerAddresses.InsertUpdateAddress(pAddress: TItemAddress);
begin
  if not ModuleDataBase.connDatabase.Connected then
    raise Exception.Create('Database is not connected');

  if not Assigned(pAddress) then
    raise Exception.Create('Address not assigned');

  var transaction : TUniTransaction := TUniTransaction.Create(nil);
  var storedProc : TUniStoredProc := TUniStoredProc.Create(nil);
  try
    try
      ModuleDataBase.PrepareStoredProcedure(storedProc, 'INSERT_UPDATE_ADDRESS', transaction);

      storedProc.ParamByName('ID_IN').Value := pAddress.Id;
      storedProc.ParamByName('STREET_IN').Value := pAddress.Street;
      storedProc.ParamByName('HOUSE_NO_IN').Value := pAddress.HouseNo;
      storedProc.ParamByName('LOCAL_NO_IN').Value := pAddress.LocalNo;
      storedProc.ParamByName('POST_CODE_IN').Value := pAddress.PostCode;
      storedProc.ParamByName('CITY_IN').Value := pAddress.City;
      storedProc.ParamByName('COUNTRY_IN').Value := pAddress.Country;
      storedProc.ParamByName('IS_DELETED_IN').Value := pAddress.IsDeleted;
      storedProc.ParamByName('ID_USER_IN').Value := TManagerUser.Instance.LoggedUser.Id;

      storedProc.ExecProc;

      pAddress.Id := storedProc.ParamByName('ID_OUT').AsInteger;

      transaction.Commit;
    except
      on E: Exception do
      begin
        if transaction.Active then
          transaction.Rollback;

        E.Message := 'Error in ' + Self.ClassName + '.InsertUpdateAddress():' + sLineBreak +
                     E.Message;
        raise;
      end;
    end;
  finally
    transaction.Free;
    storedProc.Free;
  end;
end;

class function TManagerAddresses.Instance: TManagerAddresses;
begin
  if not Assigned(FInstance) then
    FInstance := TManagerAddresses.CreateInstance;

  Result := FInstance;
end;

class procedure TManagerAddresses.ReleaseInstance;
begin
  FInstance.Free;
end;

end.

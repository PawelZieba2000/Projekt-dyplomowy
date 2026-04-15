unit cManagerWeighings;

interface

uses
  System.Generics.Collections, cDataSourceWeighings, cItemWeighing;

type
  TManagerWeighings = class
    private
      FWeighingList : TObjectList<TItemWeighing>;
      FWeighingsDS : TDataSourceWeighings;

      class var FInstance : TManagerWeighings;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property WeighingList : TObjectList<TItemWeighing> read FWeighingList;
      property WeighingDS : TDataSourceWeighings read FWeighingsDS;

      procedure GetWeighingsFromDb();
      procedure InsertUpdateWeighing(pWeighing: TItemWeighing);

      constructor Create(); overload;
      class function Instance : TManagerWeighings;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils, uModDatabase, Uni, cManagerUser, cTypes;

{ TManagerWeighings }

constructor TManagerWeighings.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TManagerWeighings.CreateInstance;
begin
  inherited Create;

  Self.FWeighingList := TObjectList<TItemWeighing>.Create();
  Self.FWeighingsDS := TDataSourceWeighings.Create(Self.FWeighingList);
end;

destructor TManagerWeighings.Destroy;
begin
  Self.FWeighingList.Free;
  Self.FWeighingsDS.Free;

  inherited;
end;

procedure TManagerWeighings.GetWeighingsFromDb;
begin
  Self.FWeighingList.Clear;

  if not ModuleDataBase.connDatabase.Connected then
    raise Exception.Create('Database is not connected');

  var sql : String := 'SELECT * FROM GET_WEIGHINGS(:ID_IN, :ID_LOCATION_IN) ';
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
        var tmpWeighing : TItemWeighing := TItemWeighing.QueryToWeighing(query);
        if Assigned(tmpWeighing) then
          Self.FWeighingList.Add(tmpWeighing);

        query.Next;
      end;
    except
      on E: Exception do
      begin
        E.Message := 'Error in ' + Self.ClassName + '.GetWeighingsFromDb():' + sLineBreak +
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

procedure TManagerWeighings.InsertUpdateWeighing(pWeighing: TItemWeighing);
begin
  if not ModuleDataBase.connDatabase.Connected then
    raise Exception.Create('Database is not connected');

  if not Assigned(pWeighing) then
    raise Exception.Create('Weighing not assigned');

  var transaction : TUniTransaction := TUniTransaction.Create(nil);
  var storedProc : TUniStoredProc := TUniStoredProc.Create(nil);
  try
    try
      ModuleDataBase.PrepareStoredProcedure(storedProc, 'INSERT_UPDATE_WEIGHING', transaction);

      storedProc.ParamByName('ID_IN').Value := pWeighing.IdErp;
      storedProc.ParamByName('CAR_NO_IN').Value := pWeighing.CarNo;
      storedProc.ParamByName('TRAILER_NO_IN').Value := pWeighing.TrailerNo;
      storedProc.ParamByName('MASS_IN_IN').Value := pWeighing.MassIn;
      storedProc.ParamByName('DATE_IN_IN').Value := pWeighing.DateIn;
      storedProc.ParamByName('MASS_OUT_IN').Value := pWeighing.MassOut;
      storedProc.ParamByName('DATE_OUT_IN').Value := pWeighing.DateOut;
      storedProc.ParamByName('WEIGHING_TYPE_IN').Value := pWeighing.WeighingType.ToInteger;
      storedProc.ParamByName('ID_CUSTOMER_IN').Value := pWeighing.Customer.IdErp;
      storedProc.ParamByName('ID_PRODUCT_IN').Value := pWeighing.Product.IdErp;
      storedProc.ParamByName('ID_USER_IN_IN').Value := pWeighing.UserIn.Id;
      storedProc.ParamByName('ID_USER_OUT_IN').Value := pWeighing.UserOut.Id;
      storedProc.ParamByName('ID_LOCATION_IN').Value := pWeighing.LocationId;
      storedProc.ParamByName('IS_DELETED_IN').Value := pWeighing.IsDeleted;

      storedProc.ExecProc;

      var resCode : Integer := storedProc.ParamByName('ERROR_CODE_OUT').AsInteger;
      if resCode <> 1 then
        raise Exception.Create('Weighing insert or update failure');

      pWeighing.Id := storedProc.ParamByName('ID_OUT').AsInteger;
      pWeighing.WeighingNo := storedProc.ParamByName('weighing_no_out').AsString;

      transaction.Commit;
    except
      on E: Exception do
      begin
        if transaction.Active then
          transaction.Rollback;

        E.Message := 'Error in ' + Self.ClassName + '.InsertUpdateWeighing():' + sLineBreak +
                     E.Message;
        raise;
      end;
    end;
  finally
    transaction.Free;
    storedProc.Free;
  end;
end;

class function TManagerWeighings.Instance: TManagerWeighings;
begin
  if not Assigned(FInstance) then
    FInstance := TManagerWeighings.CreateInstance;

  Result := FInstance;
end;

class procedure TManagerWeighings.ReleaseInstance;
begin
  FInstance.Free;
end;

end.

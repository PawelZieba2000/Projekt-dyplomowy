unit cManagerProducts;

interface

uses
  System.Generics.Collections, cItemProduct, cDataSourceProducts;

type
  TManagerProducts = class
    private
      FProductList : TObjectList<TItemProduct>;
      FProductsDS : TDataSourceProducts;

      class var FInstance : TManagerProducts;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property ProductList : TObjectList<TItemProduct> read FProductList;
      property ProductsDS : TDataSourceProducts read FProductsDS;

      procedure GetProductsFromDb();
      procedure InsertUpdateProduct(pProduct: TItemProduct);


      constructor Create(); overload;
      class function Instance : TManagerProducts;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils, uModDatabase, Uni, cManagerUser;

{ TManagerProducts }

constructor TManagerProducts.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TManagerProducts.CreateInstance;
begin
  inherited Create;

  Self.FProductList := TObjectList<TItemProduct>.Create();
  Self.FProductsDS := TDataSourceProducts.Create(Self.FProductList);
end;

destructor TManagerProducts.Destroy;
begin
  Self.FProductList.Free;
  Self.FProductsDS.Free;

  inherited;
end;

procedure TManagerProducts.GetProductsFromDb;
begin
  Self.FProductList.Clear;

  if not ModuleDataBase.connDatabase.Connected then
    raise Exception.Create('Database is not connected');

  var sql : String := 'SELECT * FROM GET_PRODUCTS(:ID_IN, :ID_LOCATION_IN) ';
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
        var tmpProduct : TItemProduct := TItemProduct.QueryToProduct(query);
        if Assigned(tmpProduct) then
          Self.FProductList.Add(tmpProduct);

        query.Next;
      end;
    except
      on E: Exception do
      begin
        E.Message := 'Error in ' + Self.ClassName + '.GetProductsFromDb():' + sLineBreak +
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

procedure TManagerProducts.InsertUpdateProduct(pProduct: TItemProduct);
begin
  if not ModuleDataBase.connDatabase.Connected then
    raise Exception.Create('Database is not connected');

  if not Assigned(pProduct) then
    raise Exception.Create('Product not assigned');

  var transaction : TUniTransaction := TUniTransaction.Create(nil);
  var storedProc : TUniStoredProc := TUniStoredProc.Create(nil);

  try
    try
      ModuleDataBase.PrepareStoredProcedure(storedProc, 'INSERT_UPDATE_PRODUCT', transaction);

      storedProc.ParamByName('ID_IN').Value := pProduct.Id;
      storedProc.ParamByName('CODE_IN').Value := pProduct.Code;
      storedProc.ParamByName('NAME_IN').Value := pProduct.Name;
      storedProc.ParamByName('PRICE_IN').Value := pProduct.Price;
      storedProc.ParamByName('IS_DELETED_IN').Value := pProduct.IsDeleted;
      storedProc.ParamByName('ID_USER_IN').Value := TManagerUser.Instance.LoggedUser.Id;

      storedProc.ExecProc;

      pProduct.Id := storedProc.FieldByName('ID_OUT').AsInteger;

      transaction.Commit;
    except
      on E: Exception do
      begin
        if transaction.Active then
          transaction.Rollback;

        E.Message := 'Error in ' + Self.ClassName + '.InsertUpdateProduct():' + sLineBreak +
                     E.Message;
        raise;
      end;
    end;
  finally
    transaction.Free;
    storedProc.Free;
  end;
end;

class function TManagerProducts.Instance: TManagerProducts;
begin
  if not Assigned(FInstance) then
    FInstance := TManagerProducts.CreateInstance;

  Result := FInstance;
end;

class procedure TManagerProducts.ReleaseInstance;
begin
  FInstance.Free;
end;

end.

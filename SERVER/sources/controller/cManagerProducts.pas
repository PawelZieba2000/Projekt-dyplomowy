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

      constructor Create(); overload;
      class function Instance : TManagerProducts;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils, uModDatabase, Uni;

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
  var sql : String := 'SELECT P.* FROM PRODUCTS P WHERE P.IS_DELETED = 0';
  var tmpQuery : TUniQuery := ModuleDataBase.OpenSql(sql);
  if not Assigned(tmpQuery) then
    Exit;

  try
    tmpQuery.First;

    while not tmpQuery.Eof do
    begin
      var tmpProduct : TItemProduct := TItemProduct.QueryToProduct(tmpQuery);
      if Assigned(tmpProduct) then
        Self.FProductList.Add(tmpProduct);

      tmpQuery.Next;
    end;
  finally
    tmpQuery.Close;
    tmpQuery.Free;
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

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

      procedure GetProducts();

      constructor Create(); overload;
      class function Instance : TManagerProducts;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils, cManagerApiService;

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

procedure TManagerProducts.GetProducts;
begin
  TManagerApiService.Instance.GetProducts(Self.FProductList);
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

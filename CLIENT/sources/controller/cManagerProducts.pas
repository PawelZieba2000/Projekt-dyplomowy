unit cManagerProducts;

interface

uses
  System.Generics.Collections, cItemProduct, cDataSourceProducts;

type
  TManagerProducts = class
    private
      FProductCustomer : TObjectList<TItemProduct>;
      FProductsDS : TDataSourceProducts;

      class var FInstance : TManagerProducts;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property ProductList : TObjectList<TItemProduct> read FProductCustomer;
      property ProductsDS : TDataSourceProducts read FProductsDS;

      constructor Create(); overload;
      class function Instance : TManagerProducts;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils;

{ TManagerProducts }

constructor TManagerProducts.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TManagerProducts.CreateInstance;
begin
  inherited Create;

  Self.FProductCustomer := TObjectList<TItemProduct>.Create();
  Self.FProductsDS := TDataSourceProducts.Create(Self.FProductCustomer);
end;

destructor TManagerProducts.Destroy;
begin
  Self.FProductCustomer.Free;
  Self.FProductsDS.Free;

  inherited;
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

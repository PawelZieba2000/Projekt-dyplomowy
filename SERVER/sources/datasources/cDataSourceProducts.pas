unit cDataSourceProducts;

interface

uses
  cxCustomData, System.Generics.Collections, cItemProduct;

type
  TDataSourceProducts = class(TcxCustomDataSource)
    private
      FProductList : TObjectList<TItemProduct>;
    protected
      function GetRecordCount: Integer; override;
      function GetValue(ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): Variant; override;
    public
      property ProductList : TObjectList<TItemProduct> read FProductList;

      function GetLine (pIndex : Integer) : TItemProduct;
      function GetLineByID (pID : Integer) : TItemProduct;

      function AppendRecord : TcxDataRecordHandle;

      constructor Create(pProductList : TObjectList<TItemProduct>); overload;
      destructor  Destroy; override;

  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ TDataSourceProducts }

function TDataSourceProducts.AppendRecord: TcxDataRecordHandle;
//var
//  tmpProduct : TProduct;
begin
//  tmpProduct           := TProduct.Create;
//  tmpProduct.IsDeleted := True;
//
//  Result := TcxDataRecordHandle(ProductsList.Add(tmpProduct));
//  DataChanged;
//  if not IsModified then IsModified := True;

end;

constructor TDataSourceProducts.Create(pProductList: TObjectList<TItemProduct>);
begin
  inherited Create;

  Self.FProductList := pProductList;
end;

destructor TDataSourceProducts.Destroy;
begin
  inherited;
end;

function TDataSourceProducts.GetLine(pIndex: Integer): TItemProduct;
begin
  Result := nil;
  if (pIndex >= 0) and (pIndex < Self.FProductList.Count) then
    Result := Self.FProductList[pIndex];
end;

function TDataSourceProducts.GetLineByID(pID: Integer): TItemProduct;
begin
  Result := nil;
  if pID <= 0 then
    Exit;

  for var product : TItemProduct in Self.FProductList do
  begin
    if product.ID = pID then
    begin
      Result := product;
      Break;
    end;
  end;
end;

function TDataSourceProducts.GetRecordCount: Integer;
begin
  Result := Self.FProductList.Count;
end;

function TDataSourceProducts.GetValue(ARecordHandle: TcxDataRecordHandle;
  AItemHandle: TcxDataItemHandle): Variant;
begin
  var recordHanleInt : Integer := Integer(ARecordHandle);
  if (recordHanleInt < 0) or (recordHanleInt >= Self.FProductList.Count) then
    Exit;

  var product : TItemProduct := Self.FProductList[recordHanleInt];
  var columnID : Integer := GetDefaultItemID(Integer(AItemHandle));

  case columnID of
    0 : Result := product.IdErp;
    1 : Result := product.Code;
    2 : Result := product.Name;
    3 : Result := product.Price;
    4 : Result := product.LocationId;
    5 : Result := product.ModificationDate;
  end;
end;

end.

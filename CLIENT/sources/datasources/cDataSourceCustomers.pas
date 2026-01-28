unit cDataSourceCustomers;

interface

uses
  cxCustomData, System.Generics.Collections, cItemCustomer;

type
  TDataSourceCustomers = class(TcxCustomDataSource)
    private
      FCustomerList : TObjectList<TItemCustomer>;
    protected
      function GetRecordCount: Integer; override;
      function GetValue(ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): Variant; override;
    public
      property CustomerList : TObjectList<TItemCustomer> read FCustomerList;

      function GetLine (pIndex : Integer) : TItemCustomer;
      function GetLineByID (pID : Integer) : TItemCustomer;

      function AppendRecord : TcxDataRecordHandle;

      constructor Create(pCustomerList : TObjectList<TItemCustomer>); overload;
      destructor  Destroy; override;

  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ TDataSourceCustomers }

function TDataSourceCustomers.AppendRecord: TcxDataRecordHandle;
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

constructor TDataSourceCustomers.Create(pCustomerList: TObjectList<TItemCustomer>);
begin
  inherited Create;

  Self.FCustomerList := pCustomerList;
end;

destructor TDataSourceCustomers.Destroy;
begin
  inherited;
end;

function TDataSourceCustomers.GetLine(pIndex: Integer): TItemCustomer;
begin
  Result := nil;
  if (pIndex >= 0) and (pIndex < Self.FCustomerList.Count) then
    Result := Self.FCustomerList[pIndex];
end;

function TDataSourceCustomers.GetLineByID(pID: Integer): TItemCustomer;
begin
  Result := nil;
  if pID <= 0 then
    Exit;

  for var customer : TItemCustomer in Self.FCustomerList do
  begin
    if customer.ID = pID then
    begin
      Result := customer;
      Break;
    end;
  end;
end;

function TDataSourceCustomers.GetRecordCount: Integer;
begin
  Result := Self.FCustomerList.Count;
end;

function TDataSourceCustomers.GetValue(ARecordHandle: TcxDataRecordHandle;
  AItemHandle: TcxDataItemHandle): Variant;
begin
  var recordHanleInt : Integer := Integer(ARecordHandle);
  if (recordHanleInt < 0) or (recordHanleInt >= Self.FCustomerList.Count) then
    Exit;

  var customer := Self.FCustomerList[recordHanleInt];
  var columnID : Integer := GetDefaultItemID(recordHanleInt);

  case columnID of
    0 : Result := customer.IdErp;
    1 : Result := customer.Code;
    2 : Result := customer.Name;
    3 : Result := customer.NIP;
    4 : Result := customer.Address.Street;
    5 : Result := customer.Address.HouseNo;
    6 : Result := customer.Address.LocalNo;
    7 : Result := customer.Address.PostCode;
    8 : Result := customer.Address.City;
    9 : Result := customer.PhoneNo;
    10 : Result := customer.LocationId;
    11 : Result := customer.ModificationDate;
  end;
end;

end.

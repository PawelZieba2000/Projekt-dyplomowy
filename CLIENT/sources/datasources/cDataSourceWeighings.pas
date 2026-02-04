unit cDataSourceWeighings;

interface

uses
  cxCustomData, System.Generics.Collections, cItemWeighing;

type
  TDataSourceWeighings = class(TcxCustomDataSource)
    private
      FWeighingList : TObjectList<TItemWeighing>;
    protected
      function GetRecordCount: Integer; override;
      function GetValue(ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): Variant; override;
    public
      property WeighingList : TObjectList<TItemWeighing> read FWeighingList;

      function GetLine (pIndex : Integer) : TItemWeighing;
      function GetLineByID (pID : Integer) : TItemWeighing;

      function AppendRecord : TcxDataRecordHandle;

      constructor Create(pWeighingList : TObjectList<TItemWeighing>); overload;
      destructor  Destroy; override;

  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ TDataSourceWeighings }

function TDataSourceWeighings.AppendRecord: TcxDataRecordHandle;
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

constructor TDataSourceWeighings.Create(pWeighingList: TObjectList<TItemWeighing>);
begin
  inherited Create;

  Self.FWeighingList := pWeighingList;
end;

destructor TDataSourceWeighings.Destroy;
begin
  inherited;
end;

function TDataSourceWeighings.GetLine(pIndex: Integer): TItemWeighing;
begin
  Result := nil;
  if (pIndex >= 0) and (pIndex < Self.FWeighingList.Count) then
    Result := Self.FWeighingList[pIndex];
end;

function TDataSourceWeighings.GetLineByID(pID: Integer): TItemWeighing;
begin
  Result := nil;
  if pID <= 0 then
    Exit;

  for var weighing : TItemWeighing in Self.FWeighingList do
  begin
    if weighing.ID = pID then
    begin
      Result := weighing;
      Break;
    end;
  end;
end;

function TDataSourceWeighings.GetRecordCount: Integer;
begin
  Result := Self.FWeighingList.Count;
end;

function TDataSourceWeighings.GetValue(ARecordHandle: TcxDataRecordHandle;
  AItemHandle: TcxDataItemHandle): Variant;
begin
  var recordHanleInt : Integer := Integer(ARecordHandle);
  if (recordHanleInt < 0) or (recordHanleInt >= Self.FWeighingList.Count) then
    Exit;

  var weighing : TItemWeighing := Self.FWeighingList[recordHanleInt];
  var columnID : Integer := GetDefaultItemID(recordHanleInt);

  case columnID of
    0 : Result := weighing.IdErp;
    1 : Result := weighing.WeighingNo;
    2 : Result := weighing.CarNo;
    3 : Result := weighing.TrailerNo;
    4 : Result := weighing.DateIn;
    5 : Result := weighing.MassIn;
    6 : Result := weighing.DateOut;
    7 : Result := weighing.MassOut;
    8 : Result := weighing.MassTare;
    9 : Result := weighing.MassNetto;
    10 : Result := weighing.Customer.IdErp;
    11 : Result := weighing.Customer.Code;
    12 : Result := weighing.Customer.Name;
    13 : Result := weighing.Product.IdErp;
    14 : Result := weighing.Product.Code;
    15 : Result := weighing.Product.Name;
    16 : Result := weighing.UserIn.FullName;
    17 : Result := weighing.UserIn.ID;
    18 : Result := weighing.UserOut.FullName;
    19 : Result := weighing.UserOut.ID;
    20 : Result := weighing.IsDeleted;
    21 : Result := weighing.ModificationDate;
  end;
end;

end.

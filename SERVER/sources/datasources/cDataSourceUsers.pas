unit cDataSourceUsers;

interface

uses
  cxCustomData, System.Generics.Collections, cItemUser;

type
  TDataSourceUsers = class(TcxCustomDataSource)
    private
      FUsersList : TObjectList<TItemUser>;
    protected
      function GetRecordCount: Integer; override;
      function GetValue(ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): Variant; override;
    public
      property UsersList : TObjectList<TItemUser> read FUsersList;

      function GetLine (pIndex : Integer) : TItemUser;
      function GetLineByID (pID : Integer) : TItemUser;

      function AppendRecord : TcxDataRecordHandle;

      constructor Create(pUserList : TObjectList<TItemUser>); overload;
      destructor  Destroy; override;

  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ TDataSourceUsers }

function TDataSourceUsers.AppendRecord: TcxDataRecordHandle;
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

constructor TDataSourceUsers.Create(pUserList: TObjectList<TItemUser>);
begin
  inherited Create;

  Self.FUsersList := pUserList;
end;

destructor TDataSourceUsers.Destroy;
begin
  inherited;
end;

function TDataSourceUsers.GetLine(pIndex: Integer): TItemUser;
begin
  Result := nil;
  if (pIndex >= 0) and (pIndex < Self.FUsersList.Count) then
    Result := Self.FUsersList[pIndex];
end;

function TDataSourceUsers.GetLineByID(pID: Integer): TItemUser;
begin
  Result := nil;
  if pID <= 0 then
    Exit;

  for var user : TItemUser in Self.FUsersList do
  begin
    if user.ID = pID then
    begin
      Result := user;
      Break;
    end;
  end;
end;

function TDataSourceUsers.GetRecordCount: Integer;
begin
  Result := Self.FUsersList.Count;
end;

function TDataSourceUsers.GetValue(ARecordHandle: TcxDataRecordHandle;
  AItemHandle: TcxDataItemHandle): Variant;
begin
  var recordHanleInt : Integer := Integer(ARecordHandle);
  if (recordHanleInt < 0) or (recordHanleInt >= Self.FUsersList.Count) then
    Exit;

  var user : TItemUser := Self.FUsersList[recordHanleInt];
  var columnID : Integer := GetDefaultItemID(Integer(AItemHandle));

  case columnID of
    0 : Result := user.Id;
    1 : Result := user.Login;
    2 : Result := user.FullName;
  end;
end;

end.

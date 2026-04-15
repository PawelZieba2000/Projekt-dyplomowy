unit cManagerUser;

interface

uses
  cItemUser, cDataSourceUsers, System.Generics.Collections;

type
  TManagerUser = class
    private
      FLoggedUser : TItemUser;

      FUsersList : TObjectList<TItemUser>;
      FUsersDS : TDataSourceUsers;

      class var FInstance : TManagerUser;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property LoggedUser : TItemUser read FLoggedUser;

      property UsersList : TObjectList<TItemUser> read FUsersList;
      property UsersDS : TDataSourceUsers read FUsersDS;

      procedure GetUsersFromDb();
      procedure InsertUpdateUser(pUser: TItemUser);

      function CheckUser(pUser : TItemUser) : Boolean;

      constructor Create(); overload;
      class function Instance : TManagerUser;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils, uModDatabase, Uni, System.Hash;

{ TManagerUser }

function TManagerUser.CheckUser(pUser: TItemUser): Boolean;
begin
  Result := False;

  if not ModuleDataBase.connDatabase.Connected then
    raise Exception.Create('Database is not connected');

  var sql : String := 'SELECT * FROM USERS WHERE ' + sLineBreak +
                      '  LOGIN = ''' + pUser.Login + ''' ' + sLineBreak +
                      '  AND USER_PASSWORD = ''' + THashSHA2.GetHashString(pUser.Password, THashSHA2.TSHA2Version.SHA256) + ''' ' + sLineBreak +
                      '  AND IS_DELETED = 0; ';
  var query : TUniQuery := TUniQuery.Create(nil);
  try
    try
      ModuleDataBase.PrepareQuery(query, sql);

      query.Open;
      query.First;

      Result := not query.Eof;
      if Result then
      begin
        pUser.Id := query.FieldByName('ID').AsInteger;
        pUser.FirstName := query.FieldByName('FIRST_NAME').AsString;
        pUser.LastName := query.FieldByName('LAST_NAME').AsString;
      end;
    except
      on E: Exception do
      begin
        E.Message := 'Error in ' + Self.ClassName + '.CheckUser():' + sLineBreak +
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

constructor TManagerUser.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TManagerUser.CreateInstance;
begin
  inherited Create;

  Self.FLoggedUser := TItemUser.Create();

  Self.FUsersList := TObjectList<TItemUser>.Create();
  Self.FUsersDS := TDataSourceUsers.Create(Self.FUsersList);
end;

destructor TManagerUser.Destroy;
begin
  Self.FLoggedUser.Free;

  Self.FUsersList.Free;
  Self.FUsersDS.Free;

  inherited;
end;

procedure TManagerUser.GetUsersFromDb;
begin
  Self.FUsersList.Clear;

  if not ModuleDataBase.connDatabase.Connected then
    raise Exception.Create('Database is not connected');

  var sql : String := 'SELECT * FROM USERS WHERE IS_DELETED = 0';
  var query : TUniQuery := TUniQuery.Create(nil);
  try
    try
      ModuleDataBase.PrepareQuery(query, sql);

      query.Open;
      query.First;

      while not query.Eof do
      begin
        var tmpUser : TItemUser := TItemUser.QueryToUser(query);
        if Assigned(tmpUser) then
          Self.FUsersList.Add(tmpUser);

        query.Next;
      end;
    except
      on E: Exception do
      begin
        E.Message := 'Error in ' + Self.ClassName + '.GetUsersFromDb():' + sLineBreak +
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

procedure TManagerUser.InsertUpdateUser(pUser: TItemUser);
begin
  if not ModuleDataBase.connDatabase.Connected then
    raise Exception.Create('Database is not connected');

  if not Assigned(pUser) then
    raise Exception.Create('User not assigned');

  var transaction : TUniTransaction := TUniTransaction.Create(nil);
  var storedProc : TUniStoredProc := TUniStoredProc.Create(nil);

  try
    try
      ModuleDataBase.PrepareStoredProcedure(storedProc, 'INSERT_UPDATE_USER', transaction);

      storedProc.ParamByName('ID_IN').Value := pUser.Id;
      storedProc.ParamByName('LOGIN_IN').Value := pUser.Login;
      storedProc.ParamByName('USER_PASSWORD_IN').Value := THashSHA2.GetHashString(pUser.Password, THashSHA2.TSHA2Version.SHA256);
      storedProc.ParamByName('FIRST_NAME_IN').Value := pUser.FirstName;
      storedProc.ParamByName('LAST_NAME_IN').Value := pUser.LastName;
      storedProc.ParamByName('ID_LOCATION_IN').Value := 1;
      storedProc.ParamByName('IS_DELETED_IN').Value := pUser.IsDeleted;

      storedProc.ExecProc;

      pUser.Id := storedProc.ParamByName('ID_OUT').AsInteger;

      transaction.Commit;
    except
      on E: Exception do
      begin
        if transaction.Active then
          transaction.Rollback;

        E.Message := 'Error in ' + Self.ClassName + '.InsertUpdateUser():' + sLineBreak +
                     E.Message;
        raise;
      end;
    end;
  finally
    transaction.Free;
    storedProc.Free;
  end;
end;

class function TManagerUser.Instance: TManagerUser;
begin
  if not Assigned(FInstance) then
    FInstance := TManagerUser.CreateInstance;

  Result := FInstance;
end;

class procedure TManagerUser.ReleaseInstance;
begin
  FInstance.Free;
end;

end.

unit cItemUser;

interface

uses
  Uni;

type
  TItemUser = class
    private
      FId : Integer;
      FLogin : String;
      FPassword : String;
      FFirstName : String;
      FLastName : String;
      FIsDeleted : Boolean;

      function GetFullName() : String;
    public
      property Id : Integer read FId write FId;
      property Login : String read FLogin write FLogin;
      property Password : String read FPassword write FPassword;
      property FirstName : String read FFirstName write FFirstName;
      property LastName : String read FLastName write FLastName;
      property IsDeleted: Boolean read FIsDeleted write FIsDeleted;

      property FullName : String read GetFullName;

      procedure SetDefaultValues();
      procedure AssignValues(const pSource : TItemUser);

      procedure FromQuery(pUserQuery : TCustomUniDataSet);
      class function QueryToUser(pUserQuery : TCustomUniDataSet) : TItemUser;

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

uses
  System.SysUtils;

{ TItemUser }

procedure TItemUser.AssignValues(const pSource: TItemUser);
begin
  if not Assigned(pSource) then
    Exit;

  Self.FId := pSource.Id;
  Self.FLogin := pSource.Login;
  Self.FPassword := pSource.Password;
  Self.FFirstName := pSource.FirstName;
  Self.FLastName := pSource.LastName;
  Self.FIsDeleted := pSource.IsDeleted;
end;

constructor TItemUser.Create;
begin
  inherited;

  Self.SetDefaultValues;
end;

destructor TItemUser.Destroy;
begin

  inherited;
end;

procedure TItemUser.FromQuery(pUserQuery: TCustomUniDataSet);
begin
  Self.Id := pUserQuery.FieldByName('ID').AsInteger;
  Self.Login := pUserQuery.FieldByName('LOGIN').AsString;
  Self.LastName := pUserQuery.FieldByName('FIRST_NAME').AsString;
  Self.FirstName := pUserQuery.FieldByName('LAST_NAME').AsString;
end;

function TItemUser.GetFullName: String;
begin
  Result := Self.FirstName + ' ' + Self.LastName;
end;

class function TItemUser.QueryToUser(pUserQuery: TCustomUniDataSet): TItemUser;
begin
  Result := nil;
  if not Assigned(pUserQuery) then
    Exit;

  Result := TItemUser.Create;
  try
    Result.FromQuery(pUserQuery);
  except
    FreeAndNil(Result);
  end;
end;

procedure TItemUser.SetDefaultValues;
begin
  Self.FId := 0;
  Self.FLogin := '';
  Self.FPassword := '';
  Self.FFirstName := '';
  Self.FLastName := '';
  Self.FIsDeleted := False;
end;

end.

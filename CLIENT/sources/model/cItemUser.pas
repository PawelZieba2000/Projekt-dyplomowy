unit cItemUser;

interface

type
  TItemUser = class
    private
      FId : Integer;
      FLogin : String;
      FPassword : String;
      FFirstName : String;
      FLastName : String;

      function GetFullName() : String;
    public
      property Id : Integer read FId write FId;
      property Login : String read FLogin write FLogin;
      property Password : String read FPassword write FPassword;
      property FirstName : String read FFirstName write FFirstName;
      property LastName : String read FLastName write FLastName;

      property FullName : String read GetFullName;

      procedure SetDefaultValues();
      procedure AssignValues(const pSource : TItemUser);

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

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

function TItemUser.GetFullName: String;
begin
  Result := Self.FirstName + ' ' + Self.LastName;
end;

procedure TItemUser.SetDefaultValues;
begin
  Self.FId := 0;
  Self.FLogin := '';
  Self.FPassword := '';
  Self.FFirstName := '';
  Self.FLastName := '';
end;

end.

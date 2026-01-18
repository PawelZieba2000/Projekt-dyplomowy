unit cManagerUser;

interface

uses
  cItemUser;

type
  TManagerUser = class
    private
      FLoggedUser : TItemUser;

      class var FInstance : TManagerUser;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property LoggedUser : TItemUser read FLoggedUser;

      constructor Create(); overload;
      class function Instance : TManagerUser;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils;

{ TManagerAdditionalData }

constructor TManagerUser.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TManagerUser.CreateInstance;
begin
  inherited Create;

  Self.FLoggedUser := TItemUser.Create();
end;

destructor TManagerUser.Destroy;
begin
  Self.FLoggedUser.Free;
  inherited;
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

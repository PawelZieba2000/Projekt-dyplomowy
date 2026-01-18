unit cManagerConfig;

interface

type
  TManagerConfig = class
    private


      class var FInstance : TManagerConfig;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      constructor Create(); overload;
      class function Instance : TManagerConfig;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils;

{ TManagerAdditionalData }

constructor TManagerConfig.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TManagerConfig.CreateInstance;
begin
  inherited Create;
end;

destructor TManagerConfig.Destroy;
begin
  inherited;
end;

class function TManagerConfig.Instance: TManagerConfig;
begin
  if not Assigned(FInstance) then
    FInstance := TManagerConfig.CreateInstance;

  Result := FInstance;
end;

class procedure TManagerConfig.ReleaseInstance;
begin
  FInstance.Free;
end;

end.

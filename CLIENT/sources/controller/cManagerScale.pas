unit cManagerScale;

interface

uses
  System.Classes, iScaleTranssmision;

type
  TManagerScale = class
    private
      FScaleConn : IScaleTranss;

      class var FInstance : TManagerScale;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      procedure ConnectWithScale;
      procedure DisconnectWithScale;


      constructor Create(); overload;
      class function Instance : TManagerScale;
      class procedure ReleaseInstance;
    public
  end;

implementation

uses
  cScaleTranssRinstrumC520, System.SysUtils, cManagerConfig, cTypes,
  cScaleTranssRhewa84, cScaleTranssmision;

{ TManagerScale }

procedure TManagerScale.ConnectWithScale;
begin
  if TManagerConfig.Instance.ScaleConfig.IsActive then
    Self.FScaleConn.Connect;
end;

constructor TManagerScale.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TManagerScale.CreateInstance;
begin
  inherited Create;
  Self.FScaleConn := nil;
  Self.FScaleConn := TScaleTranss.Create(TManagerConfig.Instance.ScaleConfig);
end;

destructor TManagerScale.Destroy;
begin
  Self.FScaleConn := nil;

  inherited;
end;

procedure TManagerScale.DisconnectWithScale;
begin
  Self.FScaleConn.Disconnect;
end;

class function TManagerScale.Instance: TManagerScale;
begin
  if not Assigned(FInstance) then
    FInstance := TManagerScale.CreateInstance;

  Result := FInstance;
end;

class procedure TManagerScale.ReleaseInstance;
begin
  if Assigned(FInstance) then
    FInstance.Free;
end;

end.

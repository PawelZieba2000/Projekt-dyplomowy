unit cConfig;

interface

uses
  cTypes, CPort;

type
  TDataBaseConfig = class;
  TRestServerConfig = class;

  TDataBaseConfig = class
    private
      FDbServer : String;
      FDbPort : Integer;
      FDbPath : String;
      FDbUsername : String;
      FDbPassword : String;
    public
      property DbServer : String read FDbServer write FDbServer;
      property DbPort : Integer read FDbPort write FDbPort;
      property DbPath : String read FDbPath write FDbPath;
      property DbUsername : String read FDbUsername write FDbUsername;
      property DbPassword : String read FDbPassword write FDbPassword;

      procedure SetDefaultValues();

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

  TRestServerConfig = class
    private
      FApPort : Integer;
      FApiLogPath : String;
      FApiUseSSL : Boolean;
    public
      property ApiPort : Integer read FApPort write FApPort;
      property ApiLogPath : String read FApiLogPath write FApiLogPath;
      property ApiUseSSL : Boolean read FApiUseSSL write FApiUseSSL;

      procedure SetDefaultValues();

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

{ TRestServerConfig }

constructor TRestServerConfig.Create;
begin
  inherited;
  Self.SetDefaultValues;
end;

destructor TRestServerConfig.Destroy;
begin
  inherited;
end;

procedure TRestServerConfig.SetDefaultValues;
begin
  Self.ApiPort := 0;
  Self.ApiLogPath := '';
  Self.ApiUseSSL := False;
end;

{ TDataBaseConfig }

constructor TDataBaseConfig.Create;
begin
  inherited;
  Self.SetDefaultValues;
end;

destructor TDataBaseConfig.Destroy;
begin
  inherited;
end;

procedure TDataBaseConfig.SetDefaultValues;
begin
  Self.DbServer := '';
  Self.DbPort := 3052;
  Self.DbPath := '';
  Self.DbUsername := '';
  Self.DbPassword := '';
end;

end.

unit cConfig;

interface

uses
  cTypes, CPort;

type
  TDataBaseConfig = class;
  TRestServerConfig = class;

  TDataBaseConfig = class
    private
      //user, login, œcie¿ka do bazy danych, adres, port
    public

      procedure SetDefaultValues();

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

  TRestServerConfig = class
    private
      //co tu w sumie potrzeba, ip, port, https chyba tyle
      FApiUrl : String;
      FApiLogPath : String;
    public
      property ApiUrl : String read FApiUrl write FApiUrl;
      property ApiLogPath : String read FApiLogPath write FApiLogPath;

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
  Self.ApiUrl := '';
  Self.ApiLogPath := '';
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
//
end;

end.

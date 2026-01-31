unit cScaleTranssRinstrumC520;

interface

uses
  System.Classes, OverbyteIcsWndControl, OverbyteIcsWSocket, Vcl.ExtCtrls,
  System.SysUtils, cTypes, CPort, cConfig, iScaleTranssmision;

type
  TTransRinstrumC520 = class(TInterfacedObject, IScaleTranss)
    private
      FDeviceClient : TWSocket;
      FComPort : TComPort;

      FConnConfig : TScaleConfig;

      FTimerTimeOut : TTimer;
      FTimerSend : TTimer;

      FTimeOutCounter : Integer;
      FReceiveData : AnsiString;
      FConnectedWithDevice : Boolean;
      FMassFromDevice : Double;

      FNewMassDT : TDateTime;

      procedure AfterConnect(Sender: TObject; Error: Word);
      procedure AfterDisconnect(Sender: TObject; Error: Word);
      procedure DataAvailable(Sender: TObject; Error: Word);

      procedure AfterOpen(Sender: TObject);
      procedure AfterClose(Sender: TObject);
      procedure OnRxChar(Sender: TObject; Count: Integer);

      function ReceiveData(pTxt : AnsiString) : Boolean;

      procedure TimerSendExecute(Sender: TObject);
      procedure TimerTimeOutExecute(Sender: TObject);

      procedure SetConnConfig(const pValue : TScaleConfig);

      function GetScaleConnected() : Boolean;
      function GetMassFromDevice() : Double;

      procedure ConnectTcpIp;
      procedure ConnectSerial;

      procedure DisconnectTcpIp;
      procedure DisconnectSerial;

      procedure SetMassFromDevice(const Value: Double);

      function GetScaleStable() : Boolean;

      property MassFromDevicePriv : Double read GetMassFromDevice write SetMassFromDevice;
    public
      property ScaleConnected : Boolean read GetScaleConnected;
      property MassFromDevice : Double read GetMassFromDevice;
      property MassStable : Boolean read GetScaleStable;

      procedure Connect;
      procedure Disconnect;

      constructor Create(); overload;
      constructor Create(const pValue : TScaleConfig); overload;
      destructor  Destroy; override;
  end;

implementation
uses
  Vcl.Dialogs, OverbyteIcsTypes, uConsts, frmWeighing, Winapi.Windows,
  System.DateUtils;

procedure TTransRinstrumC520.AfterClose(Sender: TObject);
begin
  FConnectedWithDevice := False;
end;

procedure TTransRinstrumC520.AfterConnect(Sender: TObject; Error: Word);
begin
  FTimeOutCounter := 0;
  FReceiveData := '';
  FTimerSend.Enabled := True;
end;

procedure TTransRinstrumC520.AfterDisconnect(Sender: TObject; Error: Word);
begin
  FConnectedWithDevice := False;
  if Self.ScaleConnected then
    FDeviceClient.Close;
end;

procedure TTransRinstrumC520.AfterOpen(Sender: TObject);
begin
  FTimeOutCounter := 0;
  FReceiveData := '';
  FTimerSend.Enabled := True;
end;

procedure TTransRinstrumC520.Connect;
begin
  Self.MassFromDevicePriv := SCALE_WRONG_MASS;

  case Self.FConnConfig.ConnType of
    sctSerialPort: Self.ConnectSerial;
    sctTcpIp: Self.ConnectTcpIp;
  end;
end;

procedure TTransRinstrumC520.ConnectSerial;
begin
  if FComPort.Connected then
    Exit;

  FComPort.Port := Self.FConnConfig.ComPort;
  FComPort.BaudRate := Self.FConnConfig.BaudRate;
  FComPort.DataBits := Self.FConnConfig.DataBits;
  FComPort.Parity.Bits := Self.FConnConfig.ParityBits;
  FComPort.Parity.Check := FComPort.Parity.Bits <> prNone;
  FComPort.StopBits := Self.FConnConfig.StopBits;
  FComPort.FlowControl.FlowControl := Self.FConnConfig.FlowControl;

  FComPort.OnAfterOpen := Self.AfterOpen;
  FComPort.OnAfterClose := Self.AfterClose;
  FComPort.OnRxChar := Self.OnRxChar;

  try
    FComPort.Open;

    SendMessage(FormWeighing.Handle, WM_SET_SCALE_STATUS, WPARAM(0), LPARAM(PChar(True.ToInteger.ToString)));
  except
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_STATUS, WPARAM(0), LPARAM(PChar(False.ToInteger.ToString)));
  end;
end;

procedure TTransRinstrumC520.ConnectTcpIp;
begin
  if FDeviceClient.State = wsConnected then
    Exit;

  FDeviceClient.Proto := 'tcp';
  FDeviceClient.KeepAliveOnOff := wsKeepAliveOnCustom;
  FDeviceClient.KeepAliveInterval := 2000;
  FDeviceClient.KeepAliveTime := 5000;

  FDeviceClient.Addr := Self.FConnConfig.TcpIpAddress;
  FDeviceClient.Port := Self.FConnConfig.TcpPort.ToString;

  FDeviceClient.OnSessionConnected := AfterConnect;
  FDeviceClient.OnDataAvailable    := DataAvailable;
  FDeviceClient.OnSessionClosed    := AfterDisconnect;

  try
    FDeviceClient.Connect;
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_STATUS, WPARAM(0), LPARAM(PChar(True.ToInteger.ToString)));
  except
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_STATUS, WPARAM(0), LPARAM(PChar(False.ToInteger.ToString)));
  end;
end;

constructor TTransRinstrumC520.Create(const pValue: TScaleConfig);
begin
  Self.Create();

  Self.SetConnConfig(pValue);
end;

constructor TTransRinstrumC520.Create;
begin
  inherited Create;

  FDeviceClient := TWSocket.Create(nil);
  FComPort := TComPort.Create(nil);

  FTimerSend := TTimer.Create(nil);
  FTimerSend.Interval := SCALE_TIMER_SEND_INTERVAL;
  FTimerSend.Enabled  := False;
  FTimerSend.OnTimer  := TimerSendExecute;

  FTimerTimeOut := TTimer.Create(nil);
  FTimerTimeOut.Interval := SCALE_TIMER_TIME_OUT_INTERVAL;
  FTimerTimeOut.Enabled  := False;
  FTimerTimeOut.OnTimer  := TimerTimeOutExecute;
end;

procedure TTransRinstrumC520.DataAvailable(Sender: TObject; Error: Word);
begin
  FTimerTimeOut.Enabled := False;

  var txt : AnsiString := FDeviceClient.ReceiveStr;
  if ReceiveData(txt) then
  begin
    FConnectedWithDevice := True;
    FTimeOutCounter := 0;

    var scaleMassMsg : String := Self.MassFromDevicePriv.ToString + SCALE_STATUS_SEPARATOR + Self.MassStable.ToInteger.ToString;
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_MASS, WPARAM(0), LPARAM(PChar(scaleMassMsg)));

    FTimerSend.Enabled := True;
  end else
  begin
    FTimerTimeOut.Enabled := True;
  end;
end;

destructor TTransRinstrumC520.Destroy;
begin
  FDeviceClient.Free;
  FTimerSend.Free;
  FTimerTimeOut.Free;
  inherited;
end;


procedure TTransRinstrumC520.Disconnect;
begin
  FTimerSend.Enabled := False;
  FTimerTimeOut.Enabled := False;

  case Self.FConnConfig.ConnType of
    sctSerialPort: Self.DisconnectSerial;
    sctTcpIp: Self.DisconnectTcpIp;
  end;
end;


procedure TTransRinstrumC520.DisconnectSerial;
begin
  try
    if FComPort.Connected then begin
      FComPort.Close;
      //if Assigned(FLogInfoEvent) then
      //  FLogInfoEvent(5);
    end;
  except
    //if Assigned(FLogInfoEvent) then FLogInfoEvent(6);
  end;
end;

procedure TTransRinstrumC520.DisconnectTcpIp;
begin
  try
    FDeviceClient.Close;
  except
    //
  end;
end;

function TTransRinstrumC520.GetMassFromDevice: Double;
begin
  Result := Self.FMassFromDevice;
end;

function TTransRinstrumC520.GetScaleConnected: Boolean;
begin
  Result := False;
  case Self.FConnConfig.ConnType of
    sctSerialPort: Result := Self.FComPort.Connected;
    sctTcpIp: Result := Self.FDeviceClient.State = wsConnected;
  end;
end;

function TTransRinstrumC520.GetScaleStable: Boolean;
begin
  Result := SecondsBetween(Now(), Self.FNewMassDT) >= SCALE_MIN_STABLE_TIME_SEC;
end;

procedure TTransRinstrumC520.OnRxChar(Sender: TObject; Count: Integer);
begin
  FTimerTimeOut.Enabled := False;
  var txt : AnsiString;
  FComPort.ReadAnsiStr(txt, Count);

  //if Assigned(FLogInfoEvent) then FLogInfoEvent(2, txt);
  if ReceiveData(txt) then
  begin
    FConnectedWithDevice := True;
    FTimeOutCounter := 0;

    var scaleMassMsg : String := Self.MassFromDevicePriv.ToString + SCALE_STATUS_SEPARATOR + Self.MassStable.ToInteger.ToString;
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_MASS, WPARAM(0), LPARAM(PChar(scaleMassMsg)));

    FTimerSend.Enabled := True;
  end else
  begin
    FTimerTimeOut.Enabled := True;
  end;
end;

function TTransRinstrumC520.ReceiveData(pTxt: AnsiString): Boolean;
begin
  Result := False;
  FReceiveData := FReceiveData + pTxt;
  var dataLenght : Integer := Length(FReceiveData);
  if dataLenght = 23 then
  begin
    if (FReceiveData[dataLenght - 1] = Char($0D)) and (FReceiveData[dataLenght] = Char($0A)) then
    begin
      var massAsString : AnsiString;
      for var I : Integer := 10 to 16 do
        massAsString := massAsString + FReceiveData[I];

      massAsString := Trim(massAsString);
      massAsString := StringReplace(massAsString, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
      massAsString := StringReplace(massAsString, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]);

      var tmpMass : Integer := StrToIntDef(massAsString, SCALE_WRONG_MASS);
      Result := tmpMass <> SCALE_WRONG_MASS;
      if Result then
        Self.MassFromDevicePriv := tmpMass * 1000
      else
        Self.MassFromDevicePriv := SCALE_WRONG_MASS;
    end;

    FReceiveData := '';
  end else if dataLenght > 23 then
    FReceiveData := '';
end;


procedure TTransRinstrumC520.SetConnConfig(const pValue: TScaleConfig);
begin
  if not Assigned(pValue) then
    raise Exception.Create('Scale config not assigned');

  Self.FConnConfig := pValue;
end;

procedure TTransRinstrumC520.SetMassFromDevice(const Value: Double);
begin
  if Value <> Self.FMassFromDevice then
  begin
    Self.FMassFromDevice := Value;
    Self.FNewMassDT := Now();
  end;
end;

procedure TTransRinstrumC520.TimerSendExecute(Sender: TObject);
begin
//  32 30 30 35 30 30 32 36 3A 3B 0D 0A
  FTimerSend.Enabled := False;
  FTimerTimeOut.Enabled := False;

  var sendData : TBytes;
  SetLength(sendData, 12);

  //addr
  sendData[0]  := $32;
  sendData[1]  := $30;

  //cmd
  sendData[2]  := $30;
  sendData[3]  := $35;

  //reg
  sendData[4]  := $30;
  sendData[5]  := $30;
  sendData[6]  := $32;
  sendData[7]  := $36;

  //data
  sendData[8]  := $3A;
  sendData[9]  := $3B;

  //end
  sendData[10] := $0D;
  sendData[11] := $0A;

  case Self.FConnConfig.ConnType of
    sctSerialPort: FComPort.Write(sendData, Length(sendData));
    sctTcpIp: FDeviceClient.Send(sendData, Length(sendData));
  end;

  FTimerTimeOut.Enabled := True;
end;

procedure TTransRinstrumC520.TimerTimeOutExecute(Sender: TObject);
begin
  FTimerTimeOut.Enabled := False;

  if not Self.ScaleConnected then
  begin
    Self.Connect;
    Exit;
  end;

  FReceiveData := '';
  if FTimeOutCounter > 2 then
  begin
    FConnectedWithDevice := False;
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_STATUS, WPARAM(0), LPARAM(PChar(False.ToInteger.ToString)));
  end else
  begin
    Inc(FTimeOutCounter);
    TimerSendExecute(nil);
  end;
end;

end.

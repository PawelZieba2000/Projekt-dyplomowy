unit cScaleTranssRhewa84;

interface

uses
  System.Classes, OverbyteIcsWndControl, OverbyteIcsWSocket, Vcl.ExtCtrls,
  System.SysUtils, cTypes, CPort, cConfig, iScaleTranssmision;

type
  TTransRhewa84 = class(TInterfacedObject, IScaleTranss)
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

      FMassStable : Boolean;

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
  System.DateUtils, System.AnsiStrings;

procedure TTransRhewa84.AfterClose(Sender: TObject);
begin
  FConnectedWithDevice := False;
end;

procedure TTransRhewa84.AfterConnect(Sender: TObject; Error: Word);
begin
  FTimeOutCounter := 0;
  FReceiveData := '';
  FTimerSend.Enabled := True;
end;

procedure TTransRhewa84.AfterDisconnect(Sender: TObject; Error: Word);
begin
  FConnectedWithDevice := False;
  if Self.ScaleConnected then
    FDeviceClient.Close;
end;

procedure TTransRhewa84.AfterOpen(Sender: TObject);
begin
  FTimeOutCounter := 0;
  FReceiveData := '';
  FTimerSend.Enabled := True;
end;

procedure TTransRhewa84.Connect;
begin
  Self.MassFromDevicePriv := SCALE_WRONG_MASS;
  Self.FMassStable := False;

  case Self.FConnConfig.ConnType of
    sctSerialPort: Self.ConnectSerial;
    sctTcpIp: Self.ConnectTcpIp;
  end;
end;

procedure TTransRhewa84.ConnectSerial;
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

procedure TTransRhewa84.ConnectTcpIp;
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

constructor TTransRhewa84.Create(const pValue: TScaleConfig);
begin
  Self.Create();

  Self.SetConnConfig(pValue);
end;

constructor TTransRhewa84.Create;
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

procedure TTransRhewa84.DataAvailable(Sender: TObject; Error: Word);
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

destructor TTransRhewa84.Destroy;
begin
  FDeviceClient.Free;
  FTimerSend.Free;
  FTimerTimeOut.Free;
  inherited;
end;


procedure TTransRhewa84.Disconnect;
begin
  FTimerSend.Enabled := False;
  FTimerTimeOut.Enabled := False;

  case Self.FConnConfig.ConnType of
    sctSerialPort: Self.DisconnectSerial;
    sctTcpIp: Self.DisconnectTcpIp;
  end;
end;


procedure TTransRhewa84.DisconnectSerial;
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

procedure TTransRhewa84.DisconnectTcpIp;
begin
  try
    FDeviceClient.Close;
  except
    //
  end;
end;

function TTransRhewa84.GetMassFromDevice: Double;
begin
  Result := Self.FMassFromDevice;
end;

function TTransRhewa84.GetScaleConnected: Boolean;
begin
  Result := False;
  case Self.FConnConfig.ConnType of
    sctSerialPort: Result := Self.FComPort.Connected;
    sctTcpIp: Result := Self.FDeviceClient.State = wsConnected;
  end;

  Result := Result and Self.FMassStable;
end;

function TTransRhewa84.GetScaleStable: Boolean;
begin
  Result := SecondsBetween(Now(), Self.FNewMassDT) >= SCALE_MIN_STABLE_TIME_SEC;
end;

procedure TTransRhewa84.OnRxChar(Sender: TObject; Count: Integer);
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

function TTransRhewa84.ReceiveData(pTxt: AnsiString): Boolean;
// 02 20 20 32 33 30 30 20 20 20 20 20 26 A0 30 30 30 30 30 0D 0A 04
// <STX>  2300     & 00000<CR><LF><EOT>
const frameBegin : AnsiString = #2;
      frameEnd : AnsiString = #$D#$A#4;
      frameLength : Integer = 22;
begin
  Result := False;
  FReceiveData := FReceiveData + pTxt;

  // protokol typu continous - trzeba odnalezc w otrzymancyh danych poczatek ramki i koniec ramki
  var posStart : Integer := AnsiPos(frameBegin, FReceiveData);
  if posStart = 0 then
  begin
    if Length(FReceiveData) > 2 * frameLength then
      FReceiveData := '';
    Exit;
  end;

  var dataLenght : Integer := Length(FReceiveData) - posStart + 1;
  FReceiveData := Copy(FReceiveData, posStart, dataLenght);

  var posEnd : Integer := AnsiPos(frameEnd, FReceiveData);
  if posEnd = 0 then
  begin
    if Length(FReceiveData) > 2 * frameLength then
      FReceiveData := '';
    Exit;
  end;

  FReceiveData := Copy(FReceiveData, 0, frameLength);

  dataLenght := Length(FReceiveData);
  if dataLenght = frameLength then
  begin
    if (FReceiveData[1] = frameBegin) and (Copy(FReceiveData, 20, Length(frameEnd)) = frameEnd) then
    begin
      var massAsString : AnsiString := Copy(FReceiveData, 2, 11);

      massAsString := Trim(massAsString);
      massAsString := StringReplace(massAsString, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
      massAsString := StringReplace(massAsString, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]);

      var tmpMass : Integer := StrToIntDef(massAsString, SCALE_WRONG_MASS);
      Result := (tmpMass <> SCALE_WRONG_MASS) and (FReceiveData[14] = #$A0); // dodatkowe sprawdzenie czy masa jest w kg
      if Result then
      begin
        Self.MassFromDevicePriv := tmpMass;
        var stableFlag : AnsiChar := FReceiveData[13];
        Self.FMassStable := (stableFlag = #$23) or (stableFlag = #$25) or (stableFlag = #$26);
      end else
      begin
        Self.MassFromDevicePriv := SCALE_WRONG_MASS;
        Self.FMassStable := False;
      end;
    end;

    FReceiveData := '';
  end else if dataLenght > 2 * frameLength then
    FReceiveData := '';
end;


procedure TTransRhewa84.SetConnConfig(const pValue: TScaleConfig);
begin
  if not Assigned(pValue) then
    raise Exception.Create('Scale config not assigned');

  Self.FConnConfig := pValue;
end;

procedure TTransRhewa84.SetMassFromDevice(const Value: Double);
begin
  if Value <> Self.FMassFromDevice then
  begin
    Self.FMassFromDevice := Value;
    Self.FNewMassDT := Now();
  end;
end;

procedure TTransRhewa84.TimerSendExecute(Sender: TObject);
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

procedure TTransRhewa84.TimerTimeOutExecute(Sender: TObject);
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

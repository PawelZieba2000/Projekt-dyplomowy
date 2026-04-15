unit cDataSourceTranssProtocols;

interface

uses
  cxCustomData, System.Generics.Collections, cItemTranssProtocol;

type
  TDataSourceTranssProtocols = class(TcxCustomDataSource)
    private
      FProtocolsList : TObjectList<TItemTranssProtocol>;
    protected
      function GetRecordCount: Integer; override;
      function GetValue(ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): Variant; override;
    public
      property ProtocolsList : TObjectList<TItemTranssProtocol> read FProtocolsList;

      function GetLine (pIndex : Integer) : TItemTranssProtocol;

      constructor Create(pCustomerList : TObjectList<TItemTranssProtocol>); overload;
      destructor  Destroy; override;

  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ TDataSourceTranssProtocols }

constructor TDataSourceTranssProtocols.Create(pCustomerList: TObjectList<TItemTranssProtocol>);
begin
  inherited Create;

  Self.FProtocolsList := pCustomerList;
end;

destructor TDataSourceTranssProtocols.Destroy;
begin
  inherited;
end;

function TDataSourceTranssProtocols.GetLine(pIndex: Integer): TItemTranssProtocol;
begin
  Result := nil;
  if (pIndex >= 0) and (pIndex < Self.FProtocolsList.Count) then
    Result := Self.FProtocolsList[pIndex];
end;

function TDataSourceTranssProtocols.GetRecordCount: Integer;
begin
  Result := Self.FProtocolsList.Count;
end;

function TDataSourceTranssProtocols.GetValue(ARecordHandle: TcxDataRecordHandle;
  AItemHandle: TcxDataItemHandle): Variant;
begin
  var recordHanleInt : Integer := Integer(ARecordHandle);
  if (recordHanleInt < 0) or (recordHanleInt >= Self.FProtocolsList.Count) then
    Exit;

  var transsProtocol : TItemTranssProtocol := Self.FProtocolsList[recordHanleInt];
  var columnID : Integer := GetDefaultItemID(Integer(AItemHandle));

  case columnID of
    0 : Result := transsProtocol.Id;
    1 : Result := transsProtocol.Name;
    2 : Result := transsProtocol.MessageToDevice;
    3 : Result := transsProtocol.FrameBeginning;
    4 : Result := transsProtocol.FrameEnding;
    //4 : Result := transsProtocol.FrameLength;
    //5 : Result := transsProtocol.MassPosStart;
    //6 : Result := transsProtocol.MassPosEnd;
    //7 : Result := transsProtocol.StablePos;
    //8 : Result := transsProtocol.StableSymbol;
  end;
end;

end.

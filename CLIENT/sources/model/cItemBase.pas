unit cItemBase;

interface

uses
  OverbyteIcsSuperObject;

type
  TItemBase = class
    private
    const
    {$REGION 'JSON FIELDS'}
      jf_id : String = 'id';
      jf_id_erp : String = 'id_erp';
      jf_location_id : String = 'location_id';
    {$ENDREGION}
    private
      FId : Integer;
      FIdErp : Integer;
      FLocationId : Integer;
      FModificationDate : TDateTime;
      FIsDeleted : Boolean;
      FIsModified : Boolean;

      function GetId: Integer;
      procedure SetId(const Value: Integer);
      function GetIdErp: Integer;
      procedure SetIdErp(const Value: Integer);
      function GetIsDeleted: Boolean;
      procedure SetIsDeleted(const Value: Boolean);
      function GetIsModified: Boolean;
      procedure SetIsModified(const Value: Boolean);
      function GetModificationDate: TDateTime;
      procedure SetModificationDate(const Value: TDateTime);
    function GetLocationId: Integer;
    procedure SetLocationId(const Value: Integer);
    public
      property Id: Integer read GetId write SetId;
      property IdErp: Integer read GetIdErp write SetIdErp;
      property LocationId: Integer read GetLocationId write SetLocationId;
      property ModificationDate: TDateTime read GetModificationDate write SetModificationDate;
      property IsDeleted: Boolean read GetIsDeleted write SetIsDeleted;
      property IsModified: Boolean read GetIsModified write SetIsModified;

      procedure AssignValues(const pSource : TItemBase);
      procedure SetDefaultValues(); virtual;

      function ToJson() : ISuperObject;
      procedure FromJson(pJson : ISuperObject);

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

uses
  System.SysUtils;

{ TBaseItem }

procedure TItemBase.AssignValues(const pSource: TItemBase);
begin
  if not Assigned(pSource) then
    Exit;

  Self.Id := pSource.Id;
  Self.IdErp := pSource.IdErp;
  Self.LocationId := pSource.LocationId;
  Self.ModificationDate := pSource.ModificationDate;
  Self.IsDeleted := pSource.IsDeleted;
  Self.IsModified := pSource.IsModified;
end;

constructor TItemBase.Create;
begin
  inherited;
  Self.SetDefaultValues;
end;

destructor TItemBase.Destroy;
begin
  inherited;
end;

procedure TItemBase.FromJson(pJson: ISuperObject);
begin
  if not (Assigned(pJson) and (pJson.DataType = stObject)) then
    raise Exception.Create('wrong JSON format'); ;

  Self.IdErp := pJson.I[jf_id_erp];
  Self.LocationId := pJson.I[jf_location_id];
end;

function TItemBase.GetId: Integer;
begin
  Result := Self.FId;
end;

function TItemBase.GetIdErp: Integer;
begin
  Result := Self.FIdErp;
end;

function TItemBase.GetIsDeleted: Boolean;
begin
  Result := Self.FIsDeleted;
end;

function TItemBase.GetIsModified: Boolean;
begin
  Result := Self.FIsModified;
end;

function TItemBase.GetLocationId: Integer;
begin
  Result := Self.FLocationId;
end;

function TItemBase.GetModificationDate: TDateTime;
begin
  Result := Self.FModificationDate;
end;

procedure TItemBase.SetDefaultValues;
begin
  Self.Id := 0;
  Self.IdErp := 0;
  Self.LocationId := 0;
  Self.ModificationDate := MinDateTime;
  Self.IsDeleted := False;
  Self.IsModified := False;
end;

procedure TItemBase.SetId(const Value: Integer);
begin
  if Value <> Self.Id then
    Self.FId := Value;
end;

procedure TItemBase.SetIdErp(const Value: Integer);
begin
  if Value <> Self.IdErp then
    Self.FIdErp := Value;
end;

procedure TItemBase.SetIsDeleted(const Value: Boolean);
begin
  if Value <> Self.IsDeleted then
    Self.FIsDeleted := Value;
end;

procedure TItemBase.SetIsModified(const Value: Boolean);
begin
  if Value <> Self.IsModified then
    Self.FIsModified := Value;
end;

procedure TItemBase.SetLocationId(const Value: Integer);
begin
  if Value <> Self.LocationId then
    Self.FLocationId := Value;
end;

procedure TItemBase.SetModificationDate(const Value: TDateTime);
begin
  if Value <> Self.ModificationDate then
    Self.FModificationDate := Value;
end;

function TItemBase.ToJson: ISuperObject;
begin
  Result := SO();
  //Result.I[jf_id] := Self.Id;
  Result.I[jf_id_erp] := Self.IdErp;
  Result.I[jf_location_id] := Self.LocationId;
end;

end.

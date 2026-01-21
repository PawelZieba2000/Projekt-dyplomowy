unit cHelpFunctions;

interface

uses
  System.Classes, cxGridTableView;

type
  THelpFunctions = class
    private
    public
      class procedure SetControlEnable(pControlsArray : Array of TComponent; const pEnabled : Boolean); overload;
      class procedure SetControlEnable(pControl : TComponent; const pEnabled : Boolean); overload;

      class function GetCurrentDirectory() : String;
      class function GetAppName() : String;

      class function GetActiveWindow() : TComponent;

      class procedure SetGridDefaultOptions(pGridTableView: TcxGridTableView);
  end;

implementation

uses
  System.SysUtils, Vcl.Controls, Vcl.ActnList, System.IOUtils, Vcl.Forms,
  cxFilter;

{ THelpFunctions }

class function THelpFunctions.GetActiveWindow: TComponent;
begin
  Result := FindControl(Application.ActiveFormHandle);
end;

class function THelpFunctions.GetAppName: String;
begin
  Result := ExtractFileName(Application.ExeName);
end;

class function THelpFunctions.GetCurrentDirectory: String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName));
end;

class procedure THelpFunctions.SetControlEnable(pControl: TComponent;
  const pEnabled: Boolean);
begin
  if not Assigned(pControl) then
    Exit;

  if pControl is TWinControl then
    TWinControl(pControl).Enabled := pEnabled
  else if pControl is TAction then
    TAction(pControl).Enabled := pEnabled;
end;

class procedure THelpFunctions.SetGridDefaultOptions(
  pGridTableView: TcxGridTableView);
begin
  if not Assigned(pGridTableView) then
    Exit;

  with pGridTableView.DataController do
  begin
    Filter.Options := [fcoCaseInsensitive];
  end;

  with pGridTableView.FilterRow do
  begin
    Visible := True;
    ApplyChanges := fracImmediately;
    OperatorCustomization := True;
  end;

  with pGridTableView.OptionsData do
  begin
    CancelOnExit := False;
    Deleting := False;
    DeletingConfirmation := False;
    Editing := False;
    Inserting := False;
  end;

  with pGridTableView.OptionsView do
  begin
    NoDataToDisplayInfoText := '<Brak danych do wyœwietlenia>';
    CellAutoHeight := True;
    ColumnAutoWidth := True;
    GroupByBox := False;
    HeaderAutoHeight := True;
  end;

  for var I : Integer := 0 to pGridTableView.ColumnCount - 1 do
  begin
    var tmpColumn : TcxGridColumn := pGridTableView.Columns[I];

    tmpColumn.HeaderAlignmentHorz := taCenter;
    tmpColumn.Options.FilterRowOperator := foContains;
  end;
end;

class procedure THelpFunctions.SetControlEnable(
  pControlsArray: array of TComponent; const pEnabled: Boolean);
begin
  for var tmpComp : TComponent in pControlsArray do
    THelpFunctions.SetControlEnable(tmpComp, pEnabled);
end;

end.

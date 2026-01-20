unit cHelpFunctions;

interface

uses
  System.Classes;

type
  THelpFunctions = class
    private
    public
      class procedure SetControlEnable(pControlsArray : Array of TComponent; const pEnabled : Boolean); overload;
      class procedure SetControlEnable(pControl : TComponent; const pEnabled : Boolean); overload;

      class function GetCurrentDirectory() : String;
      class function GetAppName() : String;

      class function GetActiveWindow() : TComponent;
  end;

implementation

uses
  System.SysUtils, Vcl.Controls, Vcl.ActnList, System.IOUtils, Vcl.Forms;

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

class procedure THelpFunctions.SetControlEnable(
  pControlsArray: array of TComponent; const pEnabled: Boolean);
begin
  for var tmpComp : TComponent in pControlsArray do
    THelpFunctions.SetControlEnable(tmpComp, pEnabled);
end;

end.

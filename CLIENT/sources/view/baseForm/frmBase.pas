unit frmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, dxLayoutContainer, dxLayoutControl,
  System.Actions, Vcl.ActnList, dxBar, System.ImageList, Vcl.ImgList,
  cxImageList, dxLayoutControlAdapters, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  uModDispatcher;

type
  TFormBase = class(TForm)
    lgMain: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    barmngMain: TdxBarManager;
    actlstMain: TActionList;
    lgBottom: TdxLayoutGroup;
    sprtrBottom: TdxLayoutSeparatorItem;
    lgBottomButtons: TdxLayoutGroup;
    liOk: TdxLayoutItem;
    liCancel: TdxLayoutItem;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    actOk: TAction;
    actCancel: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBase: TFormBase;

implementation

{$R *.dfm}

procedure TFormBase.actCancelExecute(Sender: TObject);
begin
//
end;

procedure TFormBase.actOkExecute(Sender: TObject);
begin
//
end;

procedure TFormBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormBase.FormDestroy(Sender: TObject);
begin
  Self := nil;
end;

end.

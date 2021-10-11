unit FindUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, StdCtrls, Buttons, ExtCtrls;

type
  TDlgFindWindow = class(TForm)
    AttachList: TImageList;
    BtnOk: TButton;
    BtnCancel: TButton;
    SearchCriteria: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Finder: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    HandleEd: TEdit;
    CaptionEd: TEdit;
    ClassEd: TEdit;
    procedure FinderMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FinderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Wnd:THandle;
    Buff:array[0..127] of char;
    { Public declarations }
  end;

var
  DlgFindWindow: TDlgFindWindow;

implementation

{$R *.dfm}
{$R Cursors.res}
const
  Target=1;

procedure TDlgFindWindow.FormCreate(Sender: TObject);
begin
  screen.Cursors[Target]:=LoadCursor(hInstance,'TARGET');
  attachlist.Draw(finder.Canvas,0,0,0);
end;

procedure TDlgFindWindow.FinderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbleft then
  begin
  finder.Picture:=nil;
  attachlist.Draw(finder.Canvas,0,0,1);
  screen.Cursor:=1;
  end;
end;

procedure TDlgFindWindow.FinderMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var p:TPoint;
begin
  Screen.Cursor:=crDefault;
  finder.Picture:=nil;
  attachlist.Draw(finder.Canvas,0,0,0);
  getcursorpos(p);
  Wnd:=WindowFromPoint(p);
  HandleEd.Text:=InttoHex(wnd,6);
  GetWindowText(wnd,Buff,SizeOf(Buff));
  CaptionEd.Text:=Buff;
  GetClassName(Wnd,Buff,SizeOf(Buff));
  ClassEd.Text:=Buff;
end;

end.

unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ComCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    AllWindows: TGroupBox;
    BtnUpdate: TButton;
    WndList: TListView;
    BtnSetAlpha: TButton;
    SortBox: TComboBox;
    Options: TGroupBox;
    Label1: TLabel;
    AlphaTrack: TTrackBar;
    BtnHide: TButton;
    BtnAbout: TButton;
    BtnExit: TButton;
    BtnAttachWindow: TButton;
    Bevel1: TBevel;
    AutoUpdate: TCheckBox;
    IntervalEdit: TEdit;
    AutoTimer: TTimer;
    ShowTimer: TTimer;
    procedure ShowTimerTimer(Sender: TObject);
    procedure BtnAboutClick(Sender: TObject);
    procedure BtnAttachWindowClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure AutoTimerTimer(Sender: TObject);
    procedure BtnHideClick(Sender: TObject);
    procedure AutoUpdateClick(Sender: TObject);
    procedure IntervalEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure AlphaTrackChange(Sender: TObject);
    procedure BtnSetAlphaClick(Sender: TObject);
    procedure BtnUpdateClick(Sender: TObject);
    procedure WMSyscommand(var MSG:TMessage);message wm_syscommand;
  private
    { Private declarations }
  public
    procedure SetAlpha(Wnd:THandle;Veto:boolean;AlphaValue:byte);
    procedure ClearHandleList;
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  HandleList:array[0..1024]of THandle;
  Buff:array[0..127] of char;
  Wnd:THandle;
  itemindex:integer;
  AlphaValue:Byte;
implementation

uses FindUnit, AboutUnit;

{$R *.dfm}
{$r windowsxp.res}
procedure TMainForm.WMSyscommand(var MSG:TMessage);
begin
  if msg.WParam=777 then BtnAboutClick(nil);
  inherited;
end;
procedure TMainForm.ClearHandleList;
var index:integer;
begin
  for index:=0 to 1024 do
    HandleList[index]:=$0;
end;

procedure TMainForm.SetAlpha(Wnd:THandle;Veto:boolean;AlphaValue:byte);
const
  cUseAlpha: array [Boolean] of Integer = (0, LWA_ALPHA);
var
  AStyle: Integer;
begin
  if not (csDesigning in ComponentState) and
    (Assigned(SetLayeredWindowAttributes)) and HandleAllocated then
  begin
    AStyle := GetWindowLong(wnd, GWL_EXSTYLE);
    if veto then
    begin
      if (AStyle and WS_EX_LAYERED) = 0 then
        SetWindowLong(wnd, GWL_EXSTYLE, AStyle or WS_EX_LAYERED);
      SetLayeredWindowAttributes(wnd, 0, AlphaValue,
        cUseAlpha[veto]);
    end
    else
    begin
      SetWindowLong(wnd, GWL_EXSTYLE, AStyle and not WS_EX_LAYERED);
      RedrawWindow(wnd, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
    end;
  end;
end;

procedure TMainForm.BtnUpdateClick(Sender: TObject);
var ClassName,WndText:string;
begin
  ClearHandleList;
  itemindex:=0;
  WndList.Items.Clear;
  Wnd:=GetWindow(handle, gw_HWndFirst);
  while wnd<>0 do
    begin
      GetWindowText(Wnd,Buff,SizeOf(Buff));
      WndText:=Buff;
      GetClassName(Wnd,Buff,SizeOf(Buff));
      ClassName:=Buff;
      if sortbox.ItemIndex=0 then
      begin
      WndList.Items.Add.Caption:=WndText;
      wndlist.Items.Item[itemindex].SubItems.Add(ClassName);
      wndlist.Items.Item[itemindex].SubItems.Add(inttohex(wnd,6));
      if (wndtext<>'')and(classname<>'') then
        wndlist.Items.Item[itemindex].Checked:=true;
      HandleList[itemindex]:=wnd;
      inc(itemindex);
      end else
      begin
        if (wndtext<>'')and(classname<>'') then
          begin
            WndList.Items.Add.Caption:=WndText;
            wndlist.Items.Item[itemindex].SubItems.Add(ClassName);
            wndlist.Items.Item[itemindex].SubItems.Add(inttohex(wnd,6));
            wndlist.Items.Item[itemindex].Checked:=true;
            HandleList[itemindex]:=wnd;
            inc(itemindex);
          end;
      end;
      Wnd:=GetWindow(Wnd, gw_hWndNext);
    end;
end;

procedure TMainForm.BtnSetAlphaClick(Sender: TObject);
begin
  for itemindex:=0 to wndlist.Items.Count-1 do
    SetAlpha(HandleList[itemindex],WndList.Items.Item[itemindex].Checked,AlphaValue);
end;

procedure TMainForm.AlphaTrackChange(Sender: TObject);
begin
  Label1.Caption:='Alpha = '+inttostr(100-AlphaTrack.Position)+' percent';
  AlphaValue:=255-(100-AlphaTrack.Position);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  AlphaTrack.Position:=20;
  AlphaTrackChange(sender);
  appendmenu(getsystemmenu(handle,false),mf_string,sc_separator,nil);
  appendmenu(getsystemmenu(handle,false),mf_string,777,'About "Alpha tool"');
end;

procedure TMainForm.IntervalEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9'] )then key:=#0;
end;

procedure TMainForm.AutoUpdateClick(Sender: TObject);
begin
  intervalEdit.Enabled:=AutoUpdate.Checked;
end;

procedure TMainForm.BtnHideClick(Sender: TObject);
begin
  AutoTimer.Interval:=StrToInt(IntervalEdit.Text);
  AutoTimer.Enabled:=AutoUpdate.Checked;
  BtnSetAlphaClick(sender);
  hide;
  ShowTimer.Enabled:=true;
end;

procedure TMainForm.AutoTimerTimer(Sender: TObject);
begin
  BtnUpdateClick(sender);
  BtnSetAlphaClick(sender);
end;

procedure TMainForm.BtnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.BtnAttachWindowClick(Sender: TObject);
begin
  Hide;
  Application.CreateForm(TDlgFindWindow, DlgFindWindow);
  if DlgFindWindow.showmodal=mrOk then
    begin
      SetAlpha(DlgFindWindow.Wnd,true,AlphaValue);
    end;
  DlgFindWindow.free;
  show;
end;

procedure TMainForm.BtnAboutClick(Sender: TObject);
begin
  Application.CreateForm(TAboutBox, AboutBox);
  AboutBox.showmodal;
  AboutBox.free;
end;

procedure TMainForm.ShowTimerTimer(Sender: TObject);
var p:TPoint;
begin
  GetCursorPos(p);
  if(p.X=0)and(p.Y=0) then begin
  show;
  showtimer.Enabled:=false;
  end;
end;

end.

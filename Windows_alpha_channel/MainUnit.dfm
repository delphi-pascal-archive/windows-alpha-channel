object MainForm: TMainForm
  Left = 232
  Top = 129
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Windows alpha-channel by M.A.D.M.A.N.'
  ClientHeight = 354
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Bevel1: TBevel
    Left = 8
    Top = 312
    Width = 713
    Height = 9
    Shape = bsTopLine
  end
  object AllWindows: TGroupBox
    Left = 8
    Top = 8
    Width = 433
    Height = 297
    Caption = ' All windows (check item for apply "ALPHA") '
    TabOrder = 4
    object BtnUpdate: TButton
      Left = 16
      Top = 256
      Width = 105
      Height = 25
      Caption = 'Update'
      TabOrder = 0
      OnClick = BtnUpdateClick
    end
    object WndList: TListView
      Left = 16
      Top = 24
      Width = 401
      Height = 225
      Checkboxes = True
      Columns = <
        item
          Caption = 'Window'
          Width = 200
        end
        item
          Caption = 'Class name'
          Width = 105
        end
        item
          Alignment = taCenter
          Caption = 'Handle'
          Width = 65
        end>
      RowSelect = True
      TabOrder = 3
      ViewStyle = vsReport
    end
    object BtnSetAlpha: TButton
      Left = 128
      Top = 256
      Width = 105
      Height = 25
      Caption = 'Set Alpha'
      TabOrder = 1
      OnClick = BtnSetAlphaClick
    end
    object SortBox: TComboBox
      Left = 241
      Top = 256
      Width = 176
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 0
      TabOrder = 2
      Text = 'All Windows'
      Items.Strings = (
        'All Windows'
        'Windows with caption')
    end
  end
  object Options: TGroupBox
    Left = 448
    Top = 8
    Width = 273
    Height = 297
    Caption = ' Options '
    TabOrder = 5
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 103
      Height = 16
      Caption = 'Alpha = 0 percent'
    end
    object AlphaTrack: TTrackBar
      Left = 16
      Top = 56
      Width = 241
      Height = 33
      Max = 100
      Frequency = 5
      TabOrder = 0
      OnChange = AlphaTrackChange
    end
    object AutoUpdate: TCheckBox
      Left = 16
      Top = 104
      Width = 193
      Height = 17
      Caption = 'Auto update and set ALPHA'
      TabOrder = 1
      OnClick = AutoUpdateClick
    end
    object IntervalEdit: TEdit
      Left = 16
      Top = 136
      Width = 241
      Height = 25
      Enabled = False
      TabOrder = 2
      Text = '100'
      OnKeyPress = IntervalEditKeyPress
    end
  end
  object BtnHide: TButton
    Left = 8
    Top = 320
    Width = 289
    Height = 25
    Caption = 'Hide to TRAY'
    TabOrder = 0
    OnClick = BtnHideClick
  end
  object BtnAbout: TButton
    Left = 512
    Top = 320
    Width = 105
    Height = 25
    Caption = 'About'
    TabOrder = 2
    OnClick = BtnAboutClick
  end
  object BtnExit: TButton
    Left = 624
    Top = 320
    Width = 97
    Height = 25
    Caption = 'Exit'
    TabOrder = 3
    OnClick = BtnExitClick
  end
  object BtnAttachWindow: TButton
    Left = 304
    Top = 320
    Width = 201
    Height = 25
    Caption = 'Attach window'
    TabOrder = 1
    OnClick = BtnAttachWindowClick
  end
  object AutoTimer: TTimer
    Enabled = False
    OnTimer = AutoTimerTimer
    Left = 40
    Top = 64
  end
  object ShowTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = ShowTimerTimer
    Left = 72
    Top = 64
  end
end

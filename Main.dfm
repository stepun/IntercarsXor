object Form1: TForm1
  Left = 169
  Top = 122
  BorderStyle = bsSingle
  Caption = 'Intercars DBF decoder'
  ClientHeight = 146
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnStart: TButton
    Left = 104
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object ProgressBar1: TProgressBar
    Left = 72
    Top = 104
    Width = 150
    Height = 17
    Min = 0
    Max = 100
    TabOrder = 1
  end
end

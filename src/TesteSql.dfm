object Form2: TForm2
  Left = 0
  Top = 0
  ClientHeight = 405
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    742
    405)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Testar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 39
    Width = 724
    Height = 355
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = 6960437
    Font.Charset = ANSI_CHARSET
    Font.Color = 16758747
    Font.Height = -19
    Font.Name = 'Fira Code Retina'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object Button2: TButton
    Left = 88
    Top = 8
    Width = 97
    Height = 25
    Caption = 'JOBCADASTRO'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 191
    Top = 8
    Width = 130
    Height = 25
    Caption = 'JOBCONIFGURACAO'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 328
    Top = 8
    Width = 137
    Height = 25
    Caption = 'JOBCONFIGURCAODET'
    TabOrder = 4
    OnClick = Button4Click
  end
end

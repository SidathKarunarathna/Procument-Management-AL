page 50114 "Material Request Line"
{
    Caption = 'Material Request Line';
    PageType = ListPart;
    SourceTable = "Material Request Line";
    AutoSplitKey = true;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Part Number"; Rec."Part Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Part Number field.';

                }
                field("ALT Part Number"; Rec."ALT Part Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ALT Part Number field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Aircraft Chapter"; Rec."Aircraft Chapter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Aircraft Chapter field.';
                }
                field("Reference Number"; Rec."Reference Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference Number field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Aircraft Type"; Rec."Aircraft Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Aircraft Type field.';
                }
            }
        }
    }

}

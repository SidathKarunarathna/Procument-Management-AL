page 50116 "Material Request List "
{
    ApplicationArea = All;
    Caption = 'Material Requests';
    PageType = List;
    SourceTable = "Material Request Header";
    UsageCategory = Lists;
    CardPageId="Material Request Card";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Used for PO"; Rec."Used for PO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Used for PO field.';
                }
                field("Requested Name"; Rec."Requested Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field(Auth; Rec.Auth)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auth field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Processed Name"; Rec."Processed Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Sent for Processing Date"; Rec."Sent for Processing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sent foe Processing Date field.';
                }
                
            }
        }
    }
}

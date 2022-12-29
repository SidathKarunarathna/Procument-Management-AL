page 50112 "Material Request Card"
{
    Caption = 'Material Request Card';
    PageType = Card;
    SourceTable = "Material Request Header";
    // UsageCategory = Documents;
    // ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Report,Request';

    layout
    {
        area(content)
        {
            group(General)
            {
                // Editable=IsEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    Caption = 'Created Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                field("Used for PO"; Rec."Used for PO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Used for PO field.';
                    Editable = false;
                }
            }

            part("Material Request Line"; "Material Request Line")
            {
                // Editable=IsEditable;
                SubPageLink = "Reqest No." = field("No.");
                ApplicationArea = all;
                UpdatePropagation = Both;
            }

            group("Requested By Details")
            {
                // Editable=IsEditable;
                field("Requested Name"; Rec."Requested Name")
                {
                    Caption = 'Name';
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
            }
            group("Processed By Details")
            {
                // Editable=IsEditable;
                field("Processed Name"; Rec."Processed Name")
                {
                    Editable = false;
                    Caption = 'Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Sent for Processing Date"; Rec."Sent for Processing Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sent foe Processing Date field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send to Processing")
            {
                ApplicationArea = All;
                Caption = 'Send to Processing';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Image = SendApprovalRequest;

                trigger OnAction()
                var
                    User: Record User;
                begin
                    Rec.TestField("Requested Name");
                    Rec.TestField(Auth);
                    Rec.TestField("Staff No.");
                    Rec.TestField(Date);
                    if Confirm('Do you want to send this for Processing') then begin
                        User.Reset();
                        User.SetRange("User Name", UserId);
                        user.FindFirst();
                        Rec.Status := Status::"Sent for Processing";
                        Rec."Sent for Processing Date" := Today;
                        Rec."Processed Name" := User."Full Name";
                        Rec.Modify();
                        Message('Successfully Sent for Processing');
                    end;
                end;
            }
        }
    }
    //     trigger OnOpenPage()
    //     begin
    //         if Rec.Status= Status::"Sent for Processing" then
    //             IsEditable:=false
    //         else if Rec.Status=Status::" Pending" then
    //             IsEditable:=true;
    //     end;
    //     var
    //         IsEditable :Boolean;
    //         Status : Enum Status;

}

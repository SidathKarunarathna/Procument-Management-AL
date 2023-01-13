pageextension 50131 "SO Processor Activies" extends "SO Processor Activities"
{
    layout
    {
        addafter("For Release")
        {
            cuegroup(Procument)
            {
                Caption = 'Procument';
                field("Pending Material Requests"; Rec."Pending Material Requests")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Material Request List ";
                    ToolTip = 'Specifies the number of Pending Material Requests.';
                }
                field("Processing Material Requests"; Rec."Processing Material Requests")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Processing Material Reqests";
                    ToolTip = 'Specifies the number of Processing Material Requests.';
                }
                field("Processed Material Requests"; Rec."Processed Material Requests")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Processed Material Requests";
                    ToolTip = 'Specifies the number of Processing Material Requests.';
                }
            }
        }
    }
}

tableextension 50130 "Sales Cue Ext" extends "Sales Cue"
{
    fields
    {
        field(50100; "Pending Material Requests"; Integer)
        {
            CalcFormula = count("Material Request Header" where(Status=filter(" Pending")));
            Caption = 'Pending Material Requests';
            Editable=false;
            FieldClass=FlowField;
            
        }
        field(50101; "Processing Material Requests"; Integer)
        {
            CalcFormula = count("Material Request Header" where(Status=filter("Sent for Processing")));
            Caption = 'Processing Material Requests';
            Editable=false;
            FieldClass=FlowField;
            
        }
        field(50102; "Processed Material Requests"; Integer)
        {
            CalcFormula = count("Material Request Header" where(Status=filter(Processed)));
            Caption = 'Processed Material Requests';
            Editable=false;
            FieldClass=FlowField;
            
        }
    }
}

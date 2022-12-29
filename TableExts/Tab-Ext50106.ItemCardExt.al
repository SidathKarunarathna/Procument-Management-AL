tableextension 50106 ItemCardExt extends Item
{
    fields
    {
        field(50100; "Internatonal Vendor Number"; Text[100])
        {
            Caption = 'Internatonal Vendor Number';
            DataClassification = ToBeClassified;
        }
        field(50101; "ATA(Aircraft Chapter)"; Text[100])
        {
            Caption = 'ATA(Aircraft Chapter)';
            DataClassification = ToBeClassified;
        }
        field(50102; CMM; Text[100])
        {
            Caption = 'CMM';
            DataClassification = ToBeClassified;
        }
        field(50103; "Alternative Part 1"; Code[20])
        {
            Caption = 'Alternative Part 1';
            DataClassification = ToBeClassified;
        }
        field(50104; "Alternative Part 2"; Code[20])
        {
            Caption = 'Alternative Part 2';
            DataClassification = ToBeClassified;
        }
        field(50105; "Alternative Part 3"; Code[20])
        {
            Caption = 'Alternative Part 3';
            DataClassification = ToBeClassified;
        }
        field(50106; "Alternative Part 4"; Code[20])
        {
            Caption = 'Alternative Part 4';
            DataClassification = ToBeClassified;
        }
        field(50107; "Type of Spare Part"; Enum Category)
        {
            Caption = 'Type of Spare Part';
            DataClassification = ToBeClassified;
        }
        field(50108; "Manufacturer Name"; Code[20 ])
        {
            Caption = 'Manufacturer Name';
            DataClassification = ToBeClassified;
            TableRelation= "Part Manufacturer";
        }
        field(50109; "Aircraft Type"; Code[20])
        {
            Caption = 'Aircraft Type';
            DataClassification = ToBeClassified;
            TableRelation="Aircraft Type";
        }
        field(50110; "FA Subclass"; Code[10])
        {
            Caption = 'FA Subclass';
            DataClassification = ToBeClassified;
            TableRelation="FA Subclass";
        }
        field(50111; "FA Class Code"; Code[10 ])
        {
            Caption = 'FA Class Code';
            DataClassification = ToBeClassified;
            TableRelation="FA Class";
        }
        field(50112; "Inv. Adj Acc"; Code[20])
        {
            Caption = 'Inv. Adj Acc';
            DataClassification = ToBeClassified;
            TableRelation="G/L Account"."No."where(Blocked=filter(false),"Direct Posting"=filter(true));
        }
        field(50113; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation=Location where ("Use As In-Transit"=const(false));
        }
        field(50114;"IPC(Reference Number)";Text[100])
        {
            Caption='IPC(Reference Number)';
            DataClassification = ToBeClassified;
        }
        field(50115;"FA Posting Group";Code[20])
        {
            Caption='FA Posting Group';
            DataClassification=ToBeClassified;
            TableRelation="FA Posting Group";
        }
        field(50116;"No. of Depreciation Years";Decimal)
        {
            Caption='No. of Depreciation Years';
            DataClassification=ToBeClassified;
        }
    }
}

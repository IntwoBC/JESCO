tableextension 50108 SalesInvHeader_Ext extends "Sales Invoice Header"
{
    fields
    {
        field(50002; "Your Reference 1"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Your Reference';
        }
        field(50003; "LC No"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'LC No';
        }
        field(50004; "Issueing Bank"; Code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Issueing Bank';
        }
        field(50005; "Our Reference"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Our Reference';
        }
        field(50006; "LPO Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'LPO Date';
        }
    }

    var
        myInt: Integer;
}
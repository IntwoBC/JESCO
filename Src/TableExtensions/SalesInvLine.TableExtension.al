tableextension 50104 SalesInvLine_Ext extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "Bill of Entry No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}
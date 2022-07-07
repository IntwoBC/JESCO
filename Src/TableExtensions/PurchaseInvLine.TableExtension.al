tableextension 50105 PurchaseInvLine_Ext extends "Purch. Inv. Line"
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
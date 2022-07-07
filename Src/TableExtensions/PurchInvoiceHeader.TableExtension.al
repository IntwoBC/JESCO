tableextension 50109 "PurchInvHeader_Ext" extends "Purch. Inv. Header"
{
    fields
    {
        //16.06.2021
        modify("Vendor Order No.")
        {
            Caption = 'Sales Order No.';
        }
    }

    var
        myInt: Integer;
}
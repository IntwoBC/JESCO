tableextension 50110 PurchCreditMemoHeader_Ext extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        //16.06.2021
        modify("Vendor Cr. Memo No.")
        {
            Caption = 'Sales Order No.';
        }
    }

    var
        myInt: Integer;
}
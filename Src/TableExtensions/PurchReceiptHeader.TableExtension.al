tableextension 50111 PurchReceiptHeader_Ext extends "Purch. Rcpt. Header"
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
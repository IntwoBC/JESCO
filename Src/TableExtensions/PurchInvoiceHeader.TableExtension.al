tableextension 50109 "PurchInvHeader_Ext" extends "Purch. Inv. Header"
{
    fields
    {
        field(50001; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Vendor Ledger Entry"."Purchase (LCY)" where("Document No." = field("No."), "Document Type" = const(Invoice), "Vendor No." = field("Pay-to Vendor No.")));
            Caption = 'Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        //16.06.2021
        modify("Vendor Order No.")
        {
            Caption = 'Sales Order No.';
        }
    }

    var
        myInt: Integer;
}
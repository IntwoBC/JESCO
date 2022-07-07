tableextension 50102 SalesLine_Ext extends "Sales Line"
{
    fields
    {
        field(50000; "Bill of Entry No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Custom Duty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Duplicate Sub Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Line Amount" where("Document No." = field("Document No."), "Document Type" = filter(Quote), "Custom Duty" = filter(false)));
        }
    }

    var
        myInt: Integer;
}
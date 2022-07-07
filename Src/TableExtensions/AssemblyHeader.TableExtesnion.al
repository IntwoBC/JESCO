tableextension 50113 "Assemble Header_Ext" extends "Assembly Header"
{
    fields
    {
        field(50000; "Total Line Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Assembly Line"."Line Amount" where("Document No." = field("No.")));
        }
    }

    var
        myInt: Integer;
}

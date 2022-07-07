tableextension 50101 "Item Ext" extends Item
{
    fields
    {
        field(50000; "Total Price Of Assembly"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("BOM Component"."Line Amount" where("Parent Item No." = field("No.")));
            Editable = false;
        }
        field(50001; "Duplicate Item"; Boolean)
        {
            Caption = 'Duplicate Item';
            DataClassification = ToBeClassified;
        }
        // field(50002; "Assemble Amount"; Decimal)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = sum("Assembly Line"."Line Amount" where( = field("No.")));
        // }
    }
}

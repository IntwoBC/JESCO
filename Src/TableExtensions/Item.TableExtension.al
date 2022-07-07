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
        field(50002; "Qty. on Sales Quote"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST(Quote),
                                                                            Type = CONST(Item),
                                                                            "No." = FIELD("No."),
                                                                            "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                            "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                            "Location Code" = FIELD("Location Filter"),
                                                                            "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                            "Variant Code" = FIELD("Variant Filter"),
                                                                            "Shipment Date" = FIELD("Date Filter"),
                                                                            "Unit of Measure Code" = FIELD("Unit of Measure Filter")));
            Caption = 'Qty. on Sales Quote';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

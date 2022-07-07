tableextension 50112 "Assembly Line Ext" extends "Assembly Line"
{
    fields
    {
        field(50000; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Price';
        }
        field(50001; "Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount %';

            trigger OnValidate();
            begin
                Rec."Discount Amount" := GetDiscountAmt();
                Rec."Line Amount" := GetLineAmt();
            end;
        }
        field(50002; "Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount Amount';
        }
        field(50003; "Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Amount';
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                ItemL: Record Item;
                SalesPriceL: Record "Sales Price";
            begin
                if ItemL.Get("No.") then begin
                    SalesPriceL.SetRange("Item No.", ItemL."No.");
                    if SalesPriceL.FindFirst() then Rec."Unit Price" := SalesPriceL."Unit Price";
                end;
            end;
        }
        modify("Quantity per")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                Rec."Discount Amount" := GetDiscountAmt();
                Rec."Line Amount" := GetLineAmt();
            end;
        }
    }
    procedure GetDiscountAmt() SendDiscountAmt: Decimal
    begin
        SendDiscountAmt := Rec."Quantity per" * Rec."Unit Price" * Rec."Discount %" / 100;
    end;

    procedure GetLineAmt() SendLineAmt: Decimal
    begin
        SendLineAmt := Rec."Quantity per" * Rec."Unit Price" - Rec."Discount Amount";
    end;
}
